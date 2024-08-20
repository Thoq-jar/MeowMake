mod syntax_definition;
mod build_system;

use crate::build_system::builder::build;
use crate::build_system::generator::generator;
use crate::syntax_definition::structure::MeowConfig;
use crate::syntax_definition::parser::parse;

fn main() {
  println!("Welcome to MeowMake!");
  println!("Checking Meowfile...");
  let config: MeowConfig = parse("Meowfile");
  println!("Preparing build...");
  let builder: String = generator(&config);
  println!("Building...");
  build(&builder);
}
