//=============================================================================
// Copyright (c) 2016-present Allan CORNET (Nelson)
//=============================================================================
// This file is part of the Nelson.
//=============================================================================
// LICENCE_BLOCK_BEGIN
// SPDX-License-Identifier: LGPL-3.0-or-later
// LICENCE_BLOCK_END
//=============================================================================
#pragma once
//=============================================================================
#ifdef _MSC_VER
#pragma warning(disable : 4251)
#endif
//=============================================================================
#include <filesystem>
#include <ctime>
#include "nlsCommons_exports.h"
//=============================================================================
namespace nfs = std::filesystem;
//=============================================================================
namespace Nelson::FileSystemWrapper {
//=============================================================================
class NLSCOMMONS_IMPEXP Path
{
    //=============================================================================
private:
    //=============================================================================
    static auto
    getUniqueID();
    //=============================================================================
    static std::wstring
    normalizeDriveLetter(const std::wstring& path, bool& isDrive);
    //=============================================================================
#ifdef _MSC_VER
    std::wstring nativePath;
#else
    std::string nativePath;
#endif
    //=============================================================================
    static Path
    removeLastSeparator(const Path& p);
    //=============================================================================
    Path&
    assign(Path const& p);
    //=============================================================================
    Path&
    concat(Path const& p);
    //=============================================================================
    Path&
    concat(const std::wstring& s);
    //=============================================================================
    Path&
    concat(const std::string& s);
    //=============================================================================

public:
    //=============================================================================
    Path() = default;
    explicit Path(Path const& p) = default;
    //=============================================================================
    Path(const std::wstring& p);
    //=============================================================================
    explicit Path(const std::string& p);
    //=============================================================================
    Path&
    operator=(Path& p);
    //=============================================================================
    Path&
    operator=(Path const& p);
    //=============================================================================
    Path&
    operator=(const std::wstring& p);
    //=============================================================================
    Path
    operator=(const std::string& p);
    //=============================================================================
    Path&
    operator+=(const std::string& s);
    //=============================================================================
    Path&
    operator+=(const std::wstring& s);
    //=============================================================================
    Path
    operator/=(Path const& p);
    //=============================================================================
    Path
    operator/=(const std::wstring& s);
    //=============================================================================
    Path
    operator/=(const std::string& s);
    //=============================================================================
    Path
    operator/(const Path& p2);
    //=============================================================================
    Path
    operator/(const std::string& p2);
    //=============================================================================
    Path
    operator/(const std::wstring& p2);
    //=============================================================================
#ifdef _MSC_VER
    std::wstring
    native() const;
#else
    std::string
    native() const;
#endif
    //=============================================================================
    bool
    has_filename() const;
    //=============================================================================
    bool
    has_extension() const;
    //=============================================================================
    Path
    extension() const;
    //=============================================================================
    std::wstring
    wstring() const;
    //=============================================================================
    std::string
    string() const;
    //=============================================================================
    std::wstring
    generic_wstring() const;
    //=============================================================================
    std::string
    generic_string() const;
    //=============================================================================
    Path
    generic_path() const;
    //=============================================================================
    Path
    filename() const;
    //=============================================================================
    Path
    parent_path() const;
    //=============================================================================
    Path
    stem() const;
    //=============================================================================
    Path
    replace_extension(Path const& new_extension = Path());
    //=============================================================================
    bool
    has_parent_path();
    //=============================================================================
    bool
    exists(std::string& errorMessage) const;
    //=============================================================================
    bool
    exists() const;
    //=============================================================================
    static bool
    exists(Path const& p);
    //=============================================================================
    static bool
    is_directory(const std::wstring& path, bool& permissionDenied);
    //=============================================================================
    static bool
    is_directory(const Path& path, bool& permissionDenied);
    //=============================================================================
    static bool
    is_directory(const std::wstring& path);
    //=============================================================================
    static bool
    is_directory(const Path& path);
    //=============================================================================
    bool
    is_directory() const;
    //=============================================================================
    bool
    is_regular_file() const;
    //=============================================================================
    static bool
    is_regular_file(const Path& filePath, bool& permissionDenied);
    //=============================================================================
    static bool
    is_regular_file(const std::wstring& filePath, bool& permissionDenied);
    //=============================================================================
    static bool
    is_regular_file(const Path& filePath);
    //=============================================================================
    static bool
    is_regular_file(const std::wstring& filePath);
    //=============================================================================
    static Path
    canonical(Path const& p1, std::string& errorMessage);
    //=============================================================================
    static bool
    equivalent(Path const& p1, Path const& p2, std::string& errorMessage);
    //=============================================================================
    static bool
    equivalent(Path const& p1, Path const& p2);
    //=============================================================================
    static bool
    remove(Path const& p, std::string& errorMessage);
    //=============================================================================
    static bool
    remove(Path const& p);
    //=============================================================================
    static bool
    remove(const std::wstring& p);
    //=============================================================================
    static bool
    remove(const std::string& p);
    //=============================================================================
    static bool
    remove_all(Path const& p, std::string& errorMessage);
    //=============================================================================
    static bool
    remove_all(Path const& p);
    //=============================================================================
    bool
    is_absolute();
    //=============================================================================
    static Path
    absolute(Path const& p, std::string& errorMessage);
    //=============================================================================
    static Path
    absolute(Path const& p);
    //=============================================================================
    static bool
    copy_file(Path const& p1, Path const& p2, std::string& errorMessage);
    //=============================================================================
    static bool
    copy_file(Path const& p1, Path const& p2);
    //=============================================================================
    static bool
    copy(Path const& from, Path const& to, std::string& errorMessage);
    //=============================================================================
    static bool
    copy(Path const& from, Path const& to);
    //=============================================================================
    static bool
    create_directories(const Path& p, std::string& errorMessage);
    //=============================================================================
    static bool
    create_directories(const Path& p, bool& permissionDenied);
    //=============================================================================
    static bool
    create_directories(const Path& p);
    //=============================================================================
    static bool
    create_directories(const std::wstring& wstr);
    //=============================================================================
    static bool
    create_directory(const Path& p, bool& permissionDenied);
    //=============================================================================
    static bool
    create_directory(const Path& p, std::string& errorMessage);
    //=============================================================================
    static bool
    create_directory(const Path& p);
    //=============================================================================
    static uintmax_t
    file_size(const Path& p, std::string& errorMessage);
    //=============================================================================
    static uintmax_t
    file_size(const Path& p);
    //=============================================================================
    static std::time_t
    last_write_time(const Path& p, std::string& errorMessage);
    //=============================================================================
    static std::time_t
    last_write_time(const Path& p);
    //=============================================================================
    Path
    lexically_normal();
    //=============================================================================
    Path
    lexically_relative(const Path& p);
    //=============================================================================
    Path
    normalize();
    //=============================================================================
    static std::wstring
    normalize(const std::wstring& path);
    //=============================================================================
    static std::string
    normalize(const std::string& path);
    //=============================================================================
    static Path
    current_path();
    //=============================================================================
    static void
    current_path(Path const& p, std::string& errorMessage);
    //=============================================================================
    static void
    current_path(Path const& p);
    //=============================================================================
    static void
    current_path(const std::wstring& wstr);
    //=============================================================================
    Path
    parent_path();
    //=============================================================================
    static Path
    temp_directory_path();
    //=============================================================================
    static Path
    unique_path();
    //=============================================================================
    static std::wstring
    getFinalPathname(const std::wstring& path);
    //=============================================================================
    Path
    getFinalPathname();
    //=============================================================================
    static bool
    updateFilePermissionsToWrite(const Path& filePath);
    //=============================================================================
    static bool
    updateFilePermissionsToWrite(const std::wstring& folderName);
    //=============================================================================
};
//=============================================================================
}
//=============================================================================
