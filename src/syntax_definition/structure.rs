#[derive(Debug)]
pub(crate) struct MeowConfig {
  pub(crate) compiler: String,
  pub(crate) src_files: Vec<String>,
  pub(crate) output: String,
  pub(crate) cflags: String,
  pub(crate) depends: Vec<String>,
  pub(crate) local_depends: Vec<String>,
}

impl MeowConfig {
  pub(crate) fn new() -> Self {
    MeowConfig {
      compiler: String::new(),
      src_files: Vec::new(),
      output: String::new(),
      cflags: String::new(),
      depends: Vec::new(),
      local_depends: Vec::new(),
    }
  }
}