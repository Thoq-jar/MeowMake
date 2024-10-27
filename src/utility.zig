const std = @import("std");

pub fn show(help: bool) void {
    const VERSION = @import("build_options").VERSION;
    const LICENSE = @import("build_options").LICENSE;
    const BANNER =
        \\   _._     _,-'""`-._
        \\(,-.`._,'(       |\`-/|
        \\    `-.-' \ )-`( , o o)
        \\          `-    \`_`"'-
    ;

    const HELP =
        \\  Help:
        \\    --version / -v - show version info
        \\    --help / -h - show this screen
        \\    no flag(s) -- build with default file (Meowfile)
    ;

    std.debug.print("{s}\n", .{BANNER});
    std.debug.print("MeowMake v{s} | License: {s}\n", .{ VERSION, LICENSE });

    if (help) {
        std.debug.print("{s}\n", .{HELP});
    }

    std.process.exit(0);
}
