const std = @import("std");
const objc = @import("objc");

pub fn main() !void {
    const version_vector: @Vector(3, i64) = .{ 15, 1, 1 };
    const success = macosVersionAtLeast(version_vector[0], version_vector[1], version_vector[2]);

    if (success) {
        std.debug.print("Your Mac OS version is at least {}.{}.{}\n", .{ version_vector[0], version_vector[1], version_vector[2] });
    } else {
        std.debug.print("Your Mac OS version is less than {}.{}.{}\n", .{ version_vector[0], version_vector[1], version_vector[2] });
    }
}

pub fn macosVersionAtLeast(major: i64, minor: i64, patch: i64) bool {
    const NSProcessInfo = objc.getClass("NSProcessInfo").?;
    const info = NSProcessInfo.msgSend(objc.Object, "processInfo", .{});
    return info.msgSend(bool, "isOperatingSystemAtLeastVersion:", .{
        NSOperatingSystemVersion{ .major = major, .minor = minor, .patch = patch },
    });
}

const NSOperatingSystemVersion = extern struct {
    major: i64,
    minor: i64,
    patch: i64,
};
