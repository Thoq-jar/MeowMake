use std::fs;
use crate::meowfile::structure::MeowConfig;

fn parse_list(value: &str) -> Vec<String> {
  value
    .trim_matches(&['[', ']'][..])
    .split(',')
    .map(|s| s.trim().trim_matches('"').to_string())
    .collect()
}

pub(crate) fn parse(file_path: &str) -> MeowConfig {
  let contents = fs::read_to_string(file_path).expect("Failed to read Meowfile!");
  let mut config = MeowConfig::new();
  let lines: Vec<&str> = contents.lines().collect();

  for line in lines {
    let line = line.trim();
    if line.starts_with('#') || line.is_empty() {
      continue;
    }
    let parts: Vec<&str> = line.split('=').collect();
    if parts.len() == 2 {
      let key = parts[0].trim();
      let value = parts[1].trim().trim_matches('"');
      match key {
        "purriler" => config.compiler = value.to_string(),
        "purroject_files" => config.src_files = parse_list(value),
        "meoutput" => config.output = value.to_string(),
        "purriler_flags" => config.cflags = value.to_string(),
        "purrepends" => config.depends = parse_list(value),
        "meocal_purrepends" => config.local_depends = parse_list(value),
        _ => (),
      }
    }
  }

  config
}
