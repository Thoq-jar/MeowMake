const std = @import("std");

pub const MeowConfig = struct {
    compiler: []const u8,
    src_files: std.ArrayList([]const u8),
    output: []const u8,
    cflags: []const u8,
    depends: std.ArrayList([]const u8),
    local_depends: std.ArrayList([]const u8),

    pub fn init(allocator: std.mem.Allocator) MeowConfig {
        return MeowConfig{
            .compiler = "",
            .src_files = std.ArrayList([]const u8).init(allocator),
            .output = "",
            .cflags = "",
            .depends = std.ArrayList([]const u8).init(allocator),
            .local_depends = std.ArrayList([]const u8).init(allocator),
        };
    }

    pub fn deinit(self: *MeowConfig) void {
        self.src_files.deinit();
        self.depends.deinit();
        self.local_depends.deinit();
    }
};

fn parseList(allocator: std.mem.Allocator, value: []const u8) !std.ArrayList([]const u8) {
    var list = std.ArrayList([]const u8).init(allocator);
    errdefer list.deinit();

    var it = std.mem.tokenize(u8, value, "[], ");
    while (it.next()) |item| {
        const trimmed = std.mem.trim(u8, item, " \t\"");
        const quoted = try std.fmt.allocPrint(allocator, "\"{s}\"", .{trimmed});
        try list.append(quoted);
    }
    return list;
}

pub fn parse(allocator: std.mem.Allocator, filename: []const u8) !MeowConfig {
    var config = MeowConfig.init(allocator);
    errdefer config.deinit();

    const file = try std.fs.cwd().openFile(filename, .{});
    defer file.close();

    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();

    var buf: [1024]u8 = undefined;
    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        var it = std.mem.split(u8, line, "=");
        const key = std.mem.trim(u8, it.next() orelse continue, " \t");
        const value = std.mem.trim(u8, it.rest(), " \t");

        if (std.mem.eql(u8, key, "purriler")) {
            config.compiler = try allocator.dupe(u8, value);
        } else if (std.mem.eql(u8, key, "purroject_files")) {
            config.src_files = try parseList(allocator, value);
        } else if (std.mem.eql(u8, key, "meoutput")) {
            config.output = try allocator.dupe(u8, value);
        } else if (std.mem.eql(u8, key, "purriler_flags")) {
            config.cflags = try allocator.dupe(u8, value);
        } else if (std.mem.eql(u8, key, "purrepends")) {
            config.depends = try parseList(allocator, value);
        } else if (std.mem.eql(u8, key, "meocal_purrepends")) {
            config.local_depends = try parseList(allocator, value);
        }
    }

    return config;
}
