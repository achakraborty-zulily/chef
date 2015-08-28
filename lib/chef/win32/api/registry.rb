#
# Author:: Salim Alam (<salam@chef.io>)
# Copyright:: Copyright 2015 Opscode, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'chef/win32/api'

class Chef
  module ReservedNames::Win32
    module API
      module Registry
        extend Chef::ReservedNames::Win32::API

        ###############################################
        # Win32 API Bindings
        ###############################################

        ffi_lib 'advapi32'

        # LONG WINAPI RegDeleteKeyEx(
        #   _In_       HKEY    hKey,
        #   _In_       LPCTSTR lpSubKey,
        #   _In_       REGSAM  samDesired,
        #   _Reserved_ DWORD   Reserved
        # );
        safe_attach_function :RegDeleteKeyExW, [ :HKEY, :LPCTSTR, :LONG, :DWORD ], :LONG
        safe_attach_function :RegDeleteKeyExA, [ :HKEY, :LPCTSTR, :LONG, :DWORD ], :LONG
        
        # LONG WINAPI RegOpenKeyEx(
        #   _In_     HKEY    hKey,
        #   _In_opt_ LPCTSTR lpSubKey,
        #   _In_     DWORD   ulOptions,
        #   _In_     REGSAM  samDesired,
        #   _Out_    PHKEY   phkResult
        # );
        safe_attach_function :RegOpenKeyExW, [ :HKEY, :LPCTSTR, :DWORD, :ULONG, :PHKEY ], :LONG
        
        # LONG WINAPI RegEnumValue(
        #   _In_        HKEY    hKey,
        #   _In_        DWORD   dwIndex,
        #   _Out_       LPTSTR  lpValueName,
        #   _Inout_     LPDWORD lpcchValueName,
        #   _Reserved_  LPDWORD lpReserved,
        #   _Out_opt_   LPDWORD lpType,
        #   _Out_opt_   LPBYTE  lpData,
        #   _Inout_opt_ LPDWORD lpcbData
        # );
        safe_attach_function :RegEnumValueW, [ :HKEY, :DWORD, :LPTSTR, :LPDWORD, :LPDWORD, :LPDWORD, :LPBYTE, :LPDWORD ], :LONG
        
        # LONG WINAPI RegQueryInfoKey(
        #   _In_        HKEY      hKey,
        #   _Out_opt_   LPTSTR    lpClass,
        #   _Inout_opt_ LPDWORD   lpcClass,
        #   _Reserved_  LPDWORD   lpReserved,
        #   _Out_opt_   LPDWORD   lpcSubKeys,
        #   _Out_opt_   LPDWORD   lpcMaxSubKeyLen,
        #   _Out_opt_   LPDWORD   lpcMaxClassLen,
        #   _Out_opt_   LPDWORD   lpcValues,
        #   _Out_opt_   LPDWORD   lpcMaxValueNameLen,
        #   _Out_opt_   LPDWORD   lpcMaxValueLen,
        #   _Out_opt_   LPDWORD   lpcbSecurityDescriptor,
        #   _Out_opt_   PFILETIME lpftLastWriteTime
        # );
        safe_attach_function :RegQueryInfoKeyW, [ :HKEY, :LPTSTR, :LPDWORD, :LPDWORD, :LPDWORD, :LPDWORD, :LPDWORD, :LPDWORD, :LPDWORD, :LPDWORD, :LPDWORD, :pointer ], :LONG
      end
    end
  end
end