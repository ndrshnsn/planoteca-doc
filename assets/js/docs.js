document.addEventListener(
    "click",
    function (e) {
        e.target.closest("[data-menu-toggle]") &&
            ((document.documentElement.dataset.menuState = "on" === document.documentElement.dataset.menuState ? "off" : "on"),
            "on" === document.documentElement.dataset.menuState
                ? (sessionStorage.setItem("scroll-position", document.documentElement.scrollTop),
                  (document.documentElement.dataset.scrollDisabled = "on"),
                  s("[data-menu]", !0),
                  (a = document
                      .querySelector("[data-menu-container]")
                      .querySelectorAll(
                          'a[href]:not([tabindex="-1"]), area[href]:not([tabindex="-1"]), input:not([disabled]):not([tabindex="-1"]), select:not([disabled]):not([tabindex="-1"]), textarea:not([disabled]):not([tabindex="-1"]), button:not([disabled]):not([tabindex="-1"]), iframe:not([tabindex="-1"]), [tabindex]:not([tabindex="-1"]), [contentEditable=true]:not([tabindex="-1"])'
                      )),
                  (c = a[0]),
                  (u = a[a.length - 1]))
                : ((document.documentElement.dataset.scrollDisabled = "off"), (document.documentElement.scrollTop = sessionStorage.getItem("scroll-position")), s("[data-menu]", !1)));
    },
)