local ffi = require("ffi")

ffi.cdef[[
int MessageBoxA(void *w, const char *txt, const char *cap, int type);
bool CreateDirectoryA(const char* lpPathName, void* lpSecurityAttributes);
int exit(int arg);

void* __stdcall URLDownloadToFileA(void* LPUNKNOWN, const char* LPCSTR, const char* LPCSTR2, int a, int LPBINDSTATUSCALLBACK);        
void* __stdcall ShellExecuteA(void* hwnd, const char* op, const char* file, const char* params, const char* dir, int show_cmd);

bool __stdcall SystemParametersInfoA(int uiAction, int uiParam, const char* pvParam, int fWinIni);

bool DeleteUrlCacheEntryA(const char* lpszUrlName);
]]

local urlmon = ffi.load 'UrlMon'
local wininet = ffi.load 'WinInet'
local shell32 = ffi.load 'Shell32'    
local winuser = ffi.load 'User32' 

function download(from, to)
    wininet.DeleteUrlCacheEntryA(from)
    urlmon.URLDownloadToFileA(nil, from, to, 0,0)
end;

local jpg_path = "C://test.jpg";

download("https://media.discordapp.net/attachments/906837102015152228/928287237190340658/SOJ29MM.jpg", jpg_path)

winuser.SystemParametersInfoA(20, 0, jpg_path, 3);

--ffi.C.exit(0);