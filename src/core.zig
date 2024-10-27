const std = @import("std");
const ChildProcess = std.process.Child;
const MeowConfig = @import("meowfile.zig").MeowConfig;

pub fn build(command: []const u8, writer: anytype) !void {
    try writer.print("Building project...\n", .{});

    var child = ChildProcess.init(&[_][]const u8{ "sh", "-c", command }, std.heap.page_allocator);

    child.stdout_behavior = .Pipe;
    child.stderr_behavior = .Pipe;

    try child.spawn();

    const stdout = child.stdout.?.reader();
    const stderr = child.stderr.?.reader();

    var buffer: [1024]u8 = undefined;
    while (true) {
        const bytes_read = try stdout.read(&buffer);
        if (bytes_read == 0) break;
        try writer.writeAll(buffer[0..bytes_read]);
    }

    while (true) {
        const bytes_read = try stderr.read(&buffer);
        if (bytes_read == 0) break;
        try writer.writeAll(buffer[0..bytes_read]);
    }

    const term = try child.wait();

    switch (term) {
        .Exited => |code| {
            if (code == 0) {
                try writer.print("Build succeeded!\n", .{});
            } else {
                try writer.print("Build failed with status: {}\n", .{code});
            }
        },
        else => try writer.print("Build failed with status: {}\n", .{term}),
    }
}

pub fn generator(config: *const MeowConfig, writer: anytype) ![]const u8 {
    var builder = std.ArrayList(u8).init(std.heap.page_allocator);
    errdefer builder.deinit();

    if (config.compiler.len == 0) {
        try writer.print("Error: Missing compiler\n", .{});
        return error.MissingCompiler;
    }

    try builder.writer().print("{s}", .{config.compiler});

    for (config.src_files.items) |file| {
        try builder.writer().print(" {s}", .{file});
    }

    if (config.output.len > 0) {
        try builder.writer().print(" -o {s}", .{config.output});
    }

    if (config.cflags.len > 0) {
        try builder.writer().print(" {s}", .{config.cflags});
    }

    for (config.depends.items) |dep| {
        try builder.writer().print(" {s}", .{dep});
    }

    for (config.local_depends.items) |dep| {
        try builder.writer().print(" {s}", .{dep});
    }

    const command = try builder.toOwnedSlice();
    return command;
}
