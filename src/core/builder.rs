use std::io::{BufRead, BufReader};
use std::process::{Command, Stdio};
use std::sync::mpsc;
use std::thread;

pub fn build(command: &str) {
    println!("Building project...");
    let mut child = Command::new("sh")
        .arg("-c")
        .arg(command)
        .stdout(Stdio::piped())
        .spawn()
        .expect("Failed to build!");

    let stdout = child.stdout.take().expect("Failed to capture stdout");
    let reader = BufReader::new(stdout);
    let (tx, rx) = mpsc::channel();

    thread::spawn(move || {
        for line in reader.lines() {
            match line {
                Ok(line) => {
                    if let Err(_) = tx.send(line) {
                        break;
                    }
                }
                Err(err) => eprintln!("Error reading line: {}", err),
            }
        }
    });

    for received in rx {
        println!("{}", received);
    }

    let status = child.wait().expect("Failed to wait on child");
    if !status.success() {
        eprintln!("Build failed with status: {}", status);
    } else {
        println!("Build succeeded!");
    }
}