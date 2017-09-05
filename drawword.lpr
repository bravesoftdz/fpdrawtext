program drawword;

{$mode objfpc}{$H+}

uses {$IFDEF UNIX} {$IFDEF UseCThreads}
  cthreads, {$ENDIF} {$ENDIF}
  Classes,
  SysUtils,
  Types,
  Interfaces {important},
  Graphics,
  IntfGraphics,
  FPimage;

  procedure PrintToConsole(const TheText: String; WithChar: AnsiChar; FontSize: Integer);
  var
    IntfImg: TLazIntfImage;
    Img: TBitmap;
    dy: Integer;
    dx: Integer;
    col: TFPColor;
    FontColor: TColor;
    c: TColor;
    aSize: TSize;
  begin
    IntfImg := nil;
    Img := TBitmap.Create;
    try
      Img.PixelFormat := pf1bit;
      aSize := Img.Canvas.TextExtent(TheText); //Get the size of string in pixles
      Img.Width := aSize.Width + 1; //reset the image size to new size
      Img.Height := aSize.Height + 1;
      Img.Canvas.Brush.Style := bsSolid;
      Img.Canvas.Brush.Color := clWhite; //Back color is white
      Img.Canvas.FillRect(0, 0, img.Width, img.Height);
      Img.Canvas.Font.Color := clBlack; //font color is black
      Img.Canvas.Font.Name := 'Arial'; //a Font can be Tahoma
      Img.Canvas.Font.Size := FontSize; //Font size, what a stupid documentation
      Img.Canvas.TextOut(0, 0, TheText);

      IntfImg := Img.CreateIntfImage;

      FontColor := ColorToRGB(clBlack);
      for dy := 0 to IntfImg.Height - 1 do
      begin
        for dx := 0 to IntfImg.Width - 1 do
        begin
          col := IntfImg.Colors[dx, dy];
          c := FPColorToTColor(col);
          if c <> FontColor then
            Write(' ')
          else
            Write(WithChar);
        end;
        Writeln;
      end;
    finally
      IntfImg.Free;
      Img.Free;
    end;
  end;

var
  c: AnsiChar;
  s: String;
  z: Integer;
begin
  Write('Enter sentence: ');
  ReadLn(s);
  Write('Enter Char: ');
  ReadLn(c);
  Write('Enter font size: ');
  ReadLn(z);
  if z = 0 then
      z := 10;
  PrintToConsole(s, c, z);
  ReadLn();
end.
