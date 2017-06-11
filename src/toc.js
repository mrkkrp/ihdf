function light() {
  sessionStorage.setItem("theme", "light");
  document.getElementById("theme-link").href="./toc-light.css"
}

function dark() {
  sessionStorage.setItem("theme", "dark");
  document.getElementById("theme-link").href="./toc-dark.css"
}

def_theme = light;

function loadTheme() {
  var theme = sessionStorage.getItem("theme");
  if (theme === "light") {
    light();
  } else if (theme === "dark") {
    dark();
  } else {
    def_theme();
  }
}

loadTheme();
