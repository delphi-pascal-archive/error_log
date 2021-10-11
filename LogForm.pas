unit LogForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, AppEvnts;

type
  TFormLog = class(TForm)
    Button1: TButton;
    Button2: TButton;
    CheckBoxSilent: TCheckBox;
    ApplicationEvents1: TApplicationEvents;
    Edit1: TEdit;
    Button3: TButton;
    Label1: TLabel;
    Button4: TButton;
    ListBox1: TListBox;
    Button5: TButton;
    Button6: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure LogException (Sender: TObject; E: Exception);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  end;

var
  FormLog: TFormLog;

implementation

{$R *.DFM}

procedure TFormLog.LogException(Sender: TObject; E: Exception);
var
 LogFile: textfile;
begin
 AssignFile(LogFile,'error_log.log');
 if FileExists('error_log.log')
 then Append(LogFile)
 else Rewrite(LogFile);
 //
 Writeln(LogFile,DateTimeToStr(Now)+': '+E.Message);
 ListBox1.Items.Add(DateTimeToStr(Now)+': '+E.Message);
 if not CheckBoxSilent.Checked // не выдавать ошибки в программе
 then Application.ShowException(E);
 //
 CloseFile(LogFile);
end;

procedure TFormLog.Button1Click(Sender: TObject);
var
 a, b: integer;
begin
 b:=0;
 a:=10 div b;
 ShowMessage(IntToStr(a));
end;

procedure TFormLog.Button2Click(Sender: TObject);
begin
 Raise Exception.Create('Raise button pressed');
end;

procedure TFormLog.Button3Click(Sender: TObject);
var
 i: integer;
begin
 i:=StrToInt(Edit1.Text);
end;

procedure TFormLog.Button4Click(Sender: TObject);
begin
 ListBox1.Items.Strings[100]:='Вставка текста во 101-ю строку';
end;

procedure TFormLog.FormCreate(Sender: TObject);
begin
 SendMessage(ListBox1.Handle,LB_SetHorizontalExtent,1000,0);
end;

procedure TFormLog.Button5Click(Sender: TObject);
var
 Str: TStringList;
begin
 Str:=TStringList.Create;
 Str.Add('Строка...');
 Str.Free;
 Str.Add('Ошибка');
end;

procedure TFormLog.Button6Click(Sender: TObject);
var
 i: integer;
 Str: TStringList;
begin
 Str:=TStringList.Create;
 Str.Add('Добавлено: Строка 1');
 Str.Add('Добавлено: Строка 2');
 Str.Add('Добавлено: Строка 3');
 for i:=0 to Str.Count do // правильно писать "Str.Count-1"
  ListBox1.Items.Add(Str.Strings[i]);
 Str.Free;
end;

end.
