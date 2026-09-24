#pragma once
#include <QCoreApplication>
#include <QDir>
#include <QFileInfo>
#include <QStandardPaths>

inline QString hypeTool(const QString &name) {
    const QString bundled = QDir(QCoreApplication::applicationDirPath()).filePath("../Resources/bin/" + name);
    if (QFileInfo(bundled).isExecutable()) return QFileInfo(bundled).absoluteFilePath();
    const QString found = QStandardPaths::findExecutable(name);
    if (!found.isEmpty()) return found;
#ifdef Q_OS_MACOS
    // Finder-launched bundles do not inherit the user's shell PATH. CLI copies
    // deliberately continue to honor PATH, which also keeps isolated builds
    // and tests reproducible.
    if (QCoreApplication::applicationDirPath().contains(".app/Contents/MacOS")) {
        for (const QString &prefix : {QString("/opt/homebrew/bin"), QString("/usr/local/bin")}) {
            const QString candidate = QDir(prefix).filePath(name);
            if (QFileInfo(candidate).isExecutable()) return candidate;
        }
    }
#endif
    return name;
}
