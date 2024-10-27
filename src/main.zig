const std = @import("std");
const meowfile = @import("meowfile.zig");
const core = @import("core.zig");
const utility = @import("utility.zig");

fn start(allocator: std.mem.Allocator, writer: anytype) !void {
    const meowfile_name = "Meowfile";

    if (std.fs.cwd().statFile(meowfile_name)) |_| {
        try writer.print("Welcome to MeowMake!\n", .{});
        try writer.print("Checking Meowfile: {s}\n", .{meowfile_name});
        var config = try meowfile.parse(allocator, meowfile_name);
        defer config.deinit();
        try writer.print("Preparing build...\n", .{});
        const builder = try core.generator(&config, writer);
        try writer.print("Building...\n", .{});
        try core.build(builder, writer);
    } else |_| {
        try writer.print("Error: Meowfile not found in the current directory.\n", .{});
        return;
    }
}

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    if (args.len == 1) {
        try start(allocator, std.io.getStdOut().writer());
    } else if (args.len == 2) {
        const second_arg = args[1];
        if (std.mem.eql(u8, second_arg, "--version") or std.mem.eql(u8, second_arg, "-v")) {
            utility.show(false);
        } else if (std.mem.eql(u8, second_arg, "--help") or std.mem.eql(u8, second_arg, "-h")) {
            utility.show(true);
        } else {
            std.debug.print("Error: Invalid arguments. Use --help for usage information.\n", .{});
        }
    } else {
        std.debug.print("Error: Invalid arguments. Use --help for usage information.\n", .{});
    }
}
