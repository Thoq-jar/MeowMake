use crate::meowfile::structure::MeowConfig;

pub fn generator(config: &MeowConfig) -> String {
  let src_files: String = config.src_files.join(" ");
  let depends: String = config.depends.join(" ");
  let local_depends: String = config.local_depends.join(" ");
  let builder = format!(
    "{} {} -o {} {} {} {}",
    config.compiler, config.cflags, config.output, src_files, local_depends, depends
  );
  println!("Setting up...");
  builder
}