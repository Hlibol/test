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
            usanswear:array[0..9] of boolean;
  end;

  { TForm1 }

  TForm1 = class(TForm)
    btn_prev: TButton;
    btn_start: TButton;
    btn_next: TButton;
    btn_result: TButton;
    CheckGroup1: TCheckGroup;
    Edit1: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    label_correct: TLabel;
    RadioGroup1: TRadioGroup;
    procedure btn_prevClick(Sender: TObject);
    procedure btn_startClick(Sender: TObject);
    procedure btn_nextClick(Sender: TObject);
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

procedure fillcheck(checkgroup1:TCheckGroup);
begin
  CheckGroup1.items.clear;
  for j:=0 to mass[i].amount-1 do
    CheckGroup1.items.add(mass[i].answear[j]);
end;



procedure chreadusanswear(checkgroup1:TCheckGroup);
begin
  for j:=0 to mass[i].amount-1 do
  begin
     mass[i].usanswear[j]:=checkgroup1.checked[j]
  end;
end;

procedure rareadusanswear(radiogroup1:TRadioGroup);
begin
  for j:=0 to mass[i].amount-1 do
  begin
     mass[i].usanswear[j]:=false;
  end;
  mass[i].usanswear[radiogroup1.ItemIndex]:=true;
end;

procedure fillradio(radiogroup1:TRadioGroup);
begin
  radioGroup1.items.clear;
  for j:=0 to mass[i].amount-1 do
  begin
    radioGroup1.items.add(mass[i].answear[j]);
  end;
end;

procedure TForm1.CheckGroup1Click(Sender: TObject);
begin

end;

procedure TForm1.btn_prevClick(Sender: TObject);
begin
    if mass[i].typ='radio' then
      rareadusanswear(radiogroup1);
   if mass[i].typ='check' then
      chreadusanswear(checkgroup1);
   btn_next.visible:=true;
   Btn_result.visible:=false;
   if i=2 then
   begin
      btn_prev.visible:=false;
   end;
   dec(i);
   label1.caption:=mass[i].question;
   if mass[i].typ='check' then
   begin
       checkgroup1.visible:=true;
       radiogroup1.visible:=false;
       fillcheck(checkgroup1);
   end;
   if mass[i].typ='radio' then
   begin
       radiogroup1.visible:=true;
       checkgroup1.visible:=false;
       fillradio(radiogroup1);
   end;

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
     mass[i].typ:=S;
     readln(fin,S);
     val(s,mass[i].amount);
     for j:=0 to mass[i].amount-1 do
     begin
        readln(fin,S);
        mass[i].answear[j]:=S;
     end;
     for j:=0 to mass[i].amount-1 do
     begin
        readln(fin,S);
        if s='1' then
           mass[i].correct[j]:=true
        else if s='0' then
           mass[i].correct[j]:=false;
     end;
     inc(i);
   end;
   N:=i-1;
   edit1.Visible:=false;
   btn_start.Visible:=false;
   label2.Visible:=false;
   i:=1;
   label1.caption:=mass[i].question;
   btn_next.visible:=true;
   if mass[i].typ='check' then
   begin
       checkgroup1.visible:=true;
       fillcheck(checkgroup1);
   end;
   if mass[i].typ='radio' then
   begin
       radiogroup1.visible:=true;
       fillradio(radiogroup1);
   end;
end;

procedure TForm1.btn_nextClick(Sender: TObject);
begin
   if mass[i].typ='radio' then
      rareadusanswear(radiogroup1);
   if mass[i].typ='check' then
      chreadusanswear(checkgroup1);
   btn_prev.visible:=true;
   if i=n-1 then
   begin
      btn_next.visible:=false;
      Btn_result.visible:=true;
   end;
   inc(i);
   label1.caption:=mass[i].question;
   if mass[i].typ='check' then
   begin
       checkgroup1.visible:=true;
       radiogroup1.visible:=false;
       fillcheck(checkgroup1);
   end;
   if mass[i].typ='radio' then
   begin
       radiogroup1.visible:=true;
       checkgroup1.visible:=false;
       fillradio(radiogroup1);
   end;

end;

end.

