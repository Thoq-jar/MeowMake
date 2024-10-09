use std::process::exit;

pub fn show(help: bool) {
  const VERSION: &str = env!("CARGO_PKG_VERSION");
  const LICENSE: &str = env!("CARGO_PKG_LICENSE");
  const BANNER: &str = r#"
   _._     _,-'""`-._
(,-.`._,'(       |\`-/|
    `-.-' \ )-`( , o o)
          `-    \`_`"'-
  "#;

  const HELP: &str = r#"
  Help:
    --version / -v - show version info
    --help / -h - show this screen
    no flag(s) -- build with default file (Meowfile)
  "#;

  println!("{}", BANNER);
  println!("MeowMake v{} | License: {}", VERSION, LICENSE);

  if help == true {
    println!("{}", HELP);
  }

  exit(0);
}