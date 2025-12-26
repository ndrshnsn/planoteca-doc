module Jekyll
  module SchemaAuto
    def self.determine_schema_type(page)
      url = page.url.to_s
      
      # Baseado no caminho da URL
      case url
      when /^\/compradores\//
        return 'guide'
      when /^\/vendedores\//
        if url.include?('cadastrar-planos') || url.include?('como-')
          return 'howto'
        else
          return 'guide'
        end
      when /^\/faq\//
        return 'faq'
      when /^\/politicas\//
        return 'legal'
      when /^\/suporte\//
        return 'support'
      when '/'
        return 'homepage'
      else
        return 'webpage'
      end
    end
    
    def self.generate_schema_data(page, site)
      schema_type = page.data['schema_type'] || determine_schema_type(page)
      
      base_data = {
        '@context' => 'https://schema.org',
        '@type' => schema_type == 'homepage' ? 'WebPage' : schema_type.capitalize,
        'url' => page.url,
        'name' => page.data['title'] || site.config['title'],
        'description' => page.data['description'] || site.config['description']
      }
      
      # Adiciona dados específicos por tipo
      case schema_type
      when 'howto'
        base_data['totalTime'] = 'PT10M'
        base_data['tool'] = {
          '@type' => 'SoftwareApplication',
          'name' => 'Planoteca',
          'applicationCategory' => 'EducationalApplication'
        }
      when 'guide'
        base_data['audience'] = {
          '@type' => 'Audience',
          'audienceType' => 'Educator'
        }
      when 'faq'
        base_data['mainEntity'] = []  # Será preenchido pelo conteúdo
      end
      
      base_data
    end
  end
  
  class SchemaGenerator < Generator
    priority :low
    
    def generate(site)
      site.pages.each do |page|
        next if page.data['exclude_from_schema']
        
        # Determina tipo de schema
        page.data['schema_type'] ||= SchemaAuto.determine_schema_type(page)
        
        # Adiciona dados do schema
        page.data['schema_data'] = SchemaAuto.generate_schema_data(page, site)
      end
    end
  end
end