mod meowfile;
mod core;
mod utility;

use crate::core::builder::build;
use crate::core::generator::generator;
use crate::meowfile::structure::MeowConfig;
use crate::meowfile::parser::parse;
use crate::utility::version::show;
use std::env;
use std::fs;

fn main() {
  let args: Vec<String> = env::args().collect();

  if args[1] == "--version" || args[1] == "-v" {
    show(false);
  } else if args[1] == "--help" || args[1] == "-h" {
    show(true);
  }

  let meowfile = "Meowfile";

  if !fs::metadata(meowfile).is_ok() {
    eprintln!("Error: Meowfile not found in the current directory.");
    return;
  }

  println!("Welcome to MeowMake!");
  println!("Checking Meowfile: {}", meowfile);
  let config: MeowConfig = parse(meowfile);
  println!("Preparing build...");
  let builder: String = generator(&config);
  println!("Building...");
  build(&builder);
}