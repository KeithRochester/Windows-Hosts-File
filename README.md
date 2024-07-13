# Windows Hosts File Maintenance Management Pack

Using the hosts file for managing name resolution really should be a last resort. That said, I recently had a requirement to add/remove hosts file entries on agents managed by SCOM. This management pack demonstrates using PowerShell based probe and write actions to read and update entries to the hosts file.

The Management Pack contains 3 tasks. All are targeted at the Microsoft Windows Computer (Microsoft.Windows.Computer) class. Links to documentation and examples below.

* [Hosts File: Get Hosts from Hosts File](<Documentation/Get Hosts from Hosts File.md>)
* [Hosts File: Update Host in Hosts File](<Documentation/Update Host In Hosts File.md>)
* [Hosts File: Remove Host from Hosts File](<Documentation/Remove Host from Hosts File.md>)
