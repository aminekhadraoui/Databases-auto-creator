program base2;
uses
  crt,
  Windows,   // for constant SW_NORMAL
  ShellApi;  // for function ShellExecute
var nomdb,nomtable: AnsiString;
 x:char;

procedure createdatabase(var nomdb: AnsiString);
var
  comand: AnsiString;
  si: STARTUPINFOA;
  pi: PROCESS_INFORMATION;
begin
   writeln('Put the name of the database :');
   readln(nomdb);
  //change the path of the mysql.exe
  comand := 'C:\AppServ\MySQL\bin\mysql.exe -uroot -ptest1234 -e "create database ' + nomdb + ' ;"';

  ZeroMemory(@si, sizeof(si));
  si.cb := sizeof(si);
  si.dwFlags := STARTF_USESHOWWINDOW;
  si.wShowWindow := SW_NORMAL;

  if CreateProcessA(nil, PAnsiChar(comand), nil, nil, False, 0, nil, nil, @si, @pi) then
  begin
    WaitForSingleObject(pi.hProcess, INFINITE);
    CloseHandle(pi.hThread);
    CloseHandle(pi.hProcess);
  clrscr;
  end else
  begin
    // error handling, use GetLastError() to find out why CreateProcess() failed...
  end;
end;

//add column to table
procedure addcolumn(nomdb,nomtable: AnsiString);
var
  typecolumn,rep,nomcolumn,comand: AnsiString;
  si: STARTUPINFOA;
  pi: PROCESS_INFORMATION;
begin
  repeat
   writeln('Put the name of column :');
   readln(nomcolumn);
   writeln('Put the type of column with the size EX:(varchar(6),int(6)) :');
   readln(typecolumn);

  //change the path of the mysql.exe
  comand := 'C:\AppServ\MySQL\bin\mysql.exe -uroot -ptest1234 -e "use ' + nomdb + ' ;ALTER TABLE '+nomtable+' ADD '+nomcolumn+' '+typecolumn+';"';

  ZeroMemory(@si, sizeof(si));
  si.cb := sizeof(si);
  si.dwFlags := STARTF_USESHOWWINDOW;
  si.wShowWindow := SW_NORMAL;

  if CreateProcessA(nil, PAnsiChar(comand), nil, nil, False, 0, nil, nil, @si, @pi) then
  begin
    WaitForSingleObject(pi.hProcess, INFINITE);
    CloseHandle(pi.hThread);
    CloseHandle(pi.hProcess);
    clrscr;
  end else
  begin
    // error handling, use GetLastError() to find out why CreateProcess() failed...
  end;
  writeln('Finish your work ? Press 0');
  readln(rep);
  until (rep='0');
end;
//end add


procedure createtable(nomdb: AnsiString;var nomtable: AnsiString);
var
  comand: AnsiString;
  si: STARTUPINFOA;
  pi: PROCESS_INFORMATION;
begin
   writeln('Put the name of the table :');
   readln(nomtable);

  //change the path of the mysql.exe
  comand := 'C:\AppServ\MySQL\bin\mysql.exe -uroot -ptest1234 -e "use ' + nomdb + ' ;create table '+nomtable+'(id int(10))"';

  ZeroMemory(@si, sizeof(si));
  si.cb := sizeof(si);
  si.dwFlags := STARTF_USESHOWWINDOW;
  si.wShowWindow := SW_NORMAL;

  if CreateProcessA(nil, PAnsiChar(comand), nil, nil, False, 0, nil, nil, @si, @pi) then
  begin
    WaitForSingleObject(pi.hProcess, INFINITE);
    CloseHandle(pi.hThread);
    CloseHandle(pi.hProcess);
    clrscr;
  end else
  begin
    // error handling, use GetLastError() to find out why CreateProcess() failed...
  end;
  addcolumn(nomdb,nomtable);
end;




procedure list(var x:char);

  begin
    TextColor(10);
    TextBackground(4);
    repeat
    writeln('Create database (1)');
    writeln;
    writeln('create table(2)');
    writeln;
    writeln('Exit (0)');
    writeln;
    TextColor(8);
    write('MySql > ');
    readln(x);
    case x of
     '1':createdatabase(nomdb);
     '2':createtable(nomdb,nomtable);
    end;
    until x='0';
  end;
begin
  list(x);

end.
