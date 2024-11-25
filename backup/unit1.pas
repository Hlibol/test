unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type
  TQuestion = record
            question:string;
            typ:string;
            amount:longint;
            answear:array[0..9] of string;
            correct:array[0..9] of boolean;
  end;

  { TForm1 }

  TForm1 = class(TForm)
    btn_prev: TButton;
    btn_next: TButton;
    Btn_result: TButton;
    btn_start: TButton;
    CheckGroup1: TCheckGroup;
    Edit1: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    label_correct: TLabel;
    RadioGroup1: TRadioGroup;
    procedure btn_prevClick(Sender: TObject);
    procedure btn_startClick(Sender: TObject);
    procedure CheckGroup1Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  fin,fout:Textfile;
  mass:array[1..100] of Tquestion;
  i,j,N:longint;
  S:string;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.CheckGroup1Click(Sender: TObject);
begin

end;

procedure TForm1.btn_prevClick(Sender: TObject);
begin

end;

procedure TForm1.btn_startClick(Sender: TObject);
begin
   assignfile(fin,edit1.Text);
   reset(fin);
   i:=1;
   while not(eof(fin)) do
   begin
     readln(fin,s);
     mass[i].question:=S;
     readln(fin,s);
     mass[i].question:=S;
     readln(fin,S);
     val(s,mas[i].amount);
   end;
   N:=i;

end;

end.

