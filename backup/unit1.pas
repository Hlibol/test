unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Menus, ExtDlgs;

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
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    label_correct: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    OpenDialog1: TOpenDialog;
    OpenPictureDialog1: TOpenPictureDialog;
    RadioGroup1: TRadioGroup;
    procedure btn_prevClick(Sender: TObject);
    procedure btn_resultClick(Sender: TObject);
    procedure btn_startClick(Sender: TObject);
    procedure btn_nextClick(Sender: TObject);
    procedure CheckGroup1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  fin,fout:Textfile;
  mass:array[1..100] of Tquestion;
  i,j,N:longint;
  S:string;
  check:boolean;

implementation

{$R *.lfm}

{ TForm1 }

procedure fillcheck(checkgroup1:TCheckGroup);
begin
  CheckGroup1.items.clear;
  for j:=0 to mass[i].amount-1 do
    CheckGroup1.items.add(mass[i].answear[j]);
end;

procedure randomq();
var ind1,ind2:longint;
    temp:Tquestion;
    tempb:boolean;
    temps:string;
begin
  randomize();
  for j:=1 to 20 do
  begin
     ind1:=1+trunc(random*(N));
     ind2:=1+trunc(random*(N));
     temp:=mass[ind1];
     mass[ind1]:=mass[ind2];
     mass[ind2]:=temp;
  end;
  for i:=1 to N do
  begin
     for j:=1 to 20 do
     begin
          ind1:=trunc(random*(mass[i].amount));
          ind2:=trunc(random*(mass[i].amount));
          temps:=mass[i].answear[ind1];
          mass[i].answear[ind1]:=mass[i].answear[ind2];
          mass[i].answear[ind2]:=temps;
          tempb:=mass[i].correct[ind1];
          mass[i].correct[ind1]:=mass[i].correct[ind2];
          mass[i].correct[ind2]:=tempb;
     end;
  end;
end;

procedure lbanswear(label2:Tlabel);
var temp:string;
begin
     temp:='Correct answer: ';
     for j:=0 to mass[i].amount-1 do
       if mass[i].correct[j] then
          temp:=temp+inttostr(j+1)+' ';
     label2.caption:=temp;
     label2.Visible:=true;
end;

procedure checkset(checkgroup1:TCheckGroup);
begin
  for j:=0 to mass[i].amount-1 do
    checkgroup1.Checked[j]:=mass[i].usanswear[j];
end;

procedure radioset(radiogroup1:TRadioGroup);
begin
  for j:=0 to mass[i].amount-1 do
    if mass[i].usanswear[j] then
       radiogroup1.Itemindex := j;
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
  if radiogroup1.ItemIndex <> -1 then
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

function radioanswear(radiogroup1:Tradiogroup):boolean;
begin
     radioanswear:=false;
     for j:=0 to mass[i].amount-1 do
        if (mass[i].usanswear[j]=mass[i].correct[j]) and (mass[i].usanswear[j]=true) then
           radioanswear:=true;
end;

function checkanswear(checkgroup1:Tcheckgroup):boolean;
var
   correctam,testam,useram:longint;
begin
     useram:=0;
     testam:=0;
     checkanswear:=false;
     correctam:=0;
      for j:=0 to mass[i].amount-1 do
      begin
          if (mass[i].usanswear[j] = mass[i].correct[j]) and (mass[i].usanswear[j]=true)
          then inc(correctam);
          if mass[i].correct[j]
          then inc(testam);
          if mass[i].usanswear[j]
          then inc(useram);
      end;
      if (correctam=testam) and (useram=testam) then
         checkanswear:=true;
end;

function calculateanswear(radiogroup1:TRadioGroup;checkgroup1:TCheckGroup):longint;
var sum:longint;
begin
     sum:=0;
   for i:=1 to N do
   begin
        if  ( mass[i].typ='checkph') or(mass[i].typ='check') then
            if checkanswear(checkgroup1) then inc(sum);
        if (mass[i].typ='radio') or( mass[i].typ='radioph') then
             if radioanswear(radiogroup1) then inc(sum);
     end;
   calculateanswear:=sum;
end;

procedure TForm1.CheckGroup1Click(Sender: TObject);
begin

end;

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

procedure TForm1.Label2Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem1Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  opendialog1.execute
end;

procedure TForm1.MenuItem4Click(Sender: TObject);
begin
  openpicturedialog1.execute;
  image1.picture.LoadFromFile();:=openpicturedialog1.FileName;
end;

procedure TForm1.btn_prevClick(Sender: TObject);
begin
    if (mass[i].typ='radio') or ( mass[i].typ='radioph') then
      rareadusanswear(radiogroup1);
   if (mass[i].typ='check') or ( mass[i].typ='checkph') then
      chreadusanswear(checkgroup1);
   btn_next.visible:=true;
   Btn_result.visible:=false;
   image1.visible:=false;
   if i=2 then
   begin
      btn_prev.visible:=false;
   end;
   dec(i);
   label1.caption:=mass[i].question;
   if  ( mass[i].typ='checkph') or (mass[i].typ='check') then
   begin
       checkgroup1.visible:=true;
       radiogroup1.visible:=false;
       fillcheck(checkgroup1);
       checkset(checkgroup1);
   end;
   if (mass[i].typ='radio') or ( mass[i].typ='radioph') then
   begin
       radiogroup1.visible:=true;
       checkgroup1.visible:=false;
       fillradio(radiogroup1);
       radioset(radiogroup1);
   end;
   if check then
      lbanswear(label2);
   if ( mass[i].typ='radioph') or ( mass[i].typ='checkph') then
      image1.visible:=true;
end;

procedure TForm1.btn_resultClick(Sender: TObject);
begin
   if (mass[i].typ='radio') or ( mass[i].typ='radioph') then
      rareadusanswear(radiogroup1);
   if (mass[i].typ='check') or ( mass[i].typ='checkph') then
      chreadusanswear(checkgroup1);
   s:=inttostr(calculateanswear(radiogroup1,checkgroup1));
   i:=N;
   label3.caption:='Your score:'+S+'/'+inttostr(N);
   btn_result.enabled:=false;
   radiogroup1.enabled:=false;
   checkgroup1.enabled:=false;
   check:=true;
   lbanswear(label2);
end;

procedure TForm1.btn_startClick(Sender: TObject);
begin
   assignfile(fin,opendialog1.filename);
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
   btn_start.Visible:=false;
   label2.Visible:=false;
   randomq();
   i:=1;
   label1.caption:=mass[i].question;
   btn_next.visible:=true;
   if (mass[i].typ='check') or ( mass[i].typ='checkph') then
   begin
       checkgroup1.visible:=true;
       fillcheck(checkgroup1);
   end;
   if ( mass[i].typ='radioph') or (mass[i].typ='radio') then
   begin
       radiogroup1.visible:=true;
       fillradio(radiogroup1);
   end;
   if n=1 then
   begin
       btn_result.visible:=true;
       btn_next.visible:=false;
   end;
   if ( mass[i].typ='radioph') or ( mass[i].typ='checkph') then
      image1.visible:=true;
end;

procedure TForm1.btn_nextClick(Sender: TObject);
begin
     if (mass[i].typ='radio') or ( mass[i].typ='radioph') then
        rareadusanswear(radiogroup1);
     if (mass[i].typ='check') or ( mass[i].typ='checkph') then
        chreadusanswear(checkgroup1);
     btn_prev.visible:=true;
     if (i=n-1)  then
     begin
        btn_next.visible:=false;
        Btn_result.visible:=true;
     end;
     image1.Visible:=false;
     inc(i);
     label1.caption:=mass[i].question;
   if ( mass[i].typ='checkph') or (mass[i].typ='check') then
   begin
       checkgroup1.visible:=true;
       radiogroup1.visible:=false;
       fillcheck(checkgroup1);
       checkset(checkgroup1);
   end;
   if (mass[i].typ='radio') or ( mass[i].typ='radioph') then
   begin
       radiogroup1.visible:=true;
       checkgroup1.visible:=false;
       fillradio(radiogroup1);
       radioset(radiogroup1)
   end;
   if check then
      lbanswear(label2);
   if ( mass[i].typ='radioph') or ( mass[i].typ='checkph') then
      image1.visible:=true;
end;

end.

