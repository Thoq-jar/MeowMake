use std::io::{BufRead, BufReader};
use std::process::{Command, Stdio};

pub fn build(command: &str) {
    println!("Building project...");
    let mut child = Command::new("sh")
        .arg("-c")
        .arg(command)
        .stdout(Stdio::piped())
        .spawn()
        .expect("Failed to build!");

    if let Some(stdout) = child.stdout.take() {
        let reader = BufReader::new(stdout);
        for line in reader.lines() {
            match line {
                Ok(line) => println!("{}", line),
                Err(err) => eprintln!("Error reading line: {}", err),
            }
        }
    }

    let status = child.wait().expect("Failed to wait on child");
    if !status.success() {
        eprintln!("Build failed with status: {}", status);
    } else {
        println!("Build succeeded!");
    }
}