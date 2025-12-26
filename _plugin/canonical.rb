Jekyll::Hooks.register :pages, :post_render do |page|
  if page.output.include?('rel="canonical"')
    page.output = page.output.gsub(
      /<link rel="canonical" href="[^"]*\/https:\/\/[^"]*"/,
      '<link rel="canonical" href="https://doc.planoteca.com.br/">'
    )
  end
end