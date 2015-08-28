#
# Author:: John Keiser (<jkeiser@opscode.com>)
# Author:: Seth Chisamore (<schisamo@opscode.com>)
# Copyright:: Copyright 2011 Opscode, Inc.
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

require 'chef/win32/api/unicode'

class Chef
  module ReservedNames::Win32
    class Unicode
      include Chef::ReservedNames::Win32::API::Unicode
      extend Chef::ReservedNames::Win32::API::Unicode
    end
  end
end

module FFI
  class Pointer
    def read_wstring(num_wchars = nil)
      if num_wchars.nil?
        num_wchars = get_wstring_len
      end

      Chef::ReservedNames::Win32::Unicode.wide_to_utf8(self.get_bytes(0, num_wchars*2))
    end
    
    def read_array_of_wstring
      result = []
      read_head_ptr = Pointer.new(address)
      num_wchars = read_head_ptr.get_wstring_len
      # read until we hit the final null terminating character
      while num_wchars > 1
        result << read_head_ptr.read_wstring(num_wchars)
        read_head_ptr = read_head_ptr + (num_wchars * 2)
        num_wchars = read_head_ptr.get_wstring_len
      end
      result
    end
    
    def get_wstring_len
      # Find the length of the string
      length = 0
      last_char = nil
      while last_char != "\000\000" do
        length += 1
        last_char = self.get_bytes(0,length * 2)[-2..-1]
      end

      length
    end
  end
end

class String
  def to_wstring
    Chef::ReservedNames::Win32::Unicode.utf8_to_wide(self)
  end
end
