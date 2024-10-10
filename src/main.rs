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

fn start() {
  let meowfile: &str = "Meowfile";

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

fn main() {
  let args: Vec<String> = env::args().collect();

  match args.as_slice() {
    [] => start(),
    [first_arg] if first_arg.ends_with("") => start(),
    [_, ref second_arg] if second_arg == "--version" || second_arg == "-v" => show(false),
    [_, ref second_arg] if second_arg == "--help" || second_arg == "-h" => show(true),
    _ => {
      eprintln!("Error: Invalid arguments. Use --help for usage information.");
    }
  }
}
