program Mapas;

{ Mapas aleatrios

  Copyright (C)  2025 Jorge Turiel, jorgeturiel@gmail.com

  Este código es software libre; usted puede redistribuirlo y/o modificarlo
  bajo los términos de la GNU General Public License publicada por la Free
  Software Foundation; sea versión 2 de la Licencia, o (a su opción)
  cualquier versión posterior.

  Este código se distribuye con la esperanza de que sea útil, pero SIN
  NINGUNA GARANTÍA, ni siquiera la garantía implícita de COMERCIABILIDAD o
  IDONEIDAD PARA UN DETERMINADO FIN.  Consulte la GNU General Public License
  para obtener más detalles.

  Una copia de la Licencia Pública General de GNU está disponible en la
  World Wide Web en <http://www.gnu.org/copyleft/gpl.html>. También puede
  obtenerlo por escrito de la Free Software Foundation, Inc., 59 Temple Place
  - Suite 330, Boston, MA 02111-1307, USA.
}

{Images from here:
https://opengameart.org/content/16x16-minimalistic-rpg-spritessome-tiles
}
uses
  SysUtils,
  BGRABitmap,
  BGRABitmapTypes;

type
  Tmap = array of array of char;

  function GenerateMap(AAncho: integer; AAlto: integer): Tmap;
  var
    Y, X: integer;
  begin
    Result := Tmap.Create;
    SetLength(Result, AAncho, AAlto);
    for Y := 0 to AAncho - 1 do
    begin
      for x := 0 to AAlto - 1 do
      begin
        if Random() < 0.15 then
        begin
          Result[y, x] := '#';
        end
        else
        begin
          Result[y, x] := '.';
        end;
      end;
    end;

  end;

  procedure PrintMap(AMap: Tmap);
  var
    Y, X: integer;
  begin
    for Y := 0 to High(AMap) do
    begin
      for X := 0 to High(AMap[1]) do
      begin
        Write(AMap[y, x]);
      end;
      Writeln();
    end;
  end;


  procedure SaveMapAsImage(AMap: Tmap; AFileName: TFilename);
  var
    Ancho, Alto, Y, X: integer;
    Tree, Grass: TBGRABitmap;
    Image: TBGRABitmap;
  begin
    Ancho := High(AMap);
    Alto := High(AMap[1]);

    Tree := TBGRABitmap.Create;
    Grass := TBGRABitmap.Create;
    Image := TBGRABitmap.Create(Ancho * 16, Alto * 16);

    Tree.LoadFromFile('tree.png');
    Grass.LoadFromFile('grass.png');

    for X := 0 to Ancho  do
    begin
      for Y := 0 to Alto do
      begin
        if AMap[X, Y] = '#' then
        begin
          Image.PutImage(X * 16, Y * 16, Tree, dmSet);
        end
        else
        begin
          Image.PutImage(X * 16, Y * 16, Grass, dmSet);
        end;
      end;
    end;
    Image.SaveToFile(AFileName);
    FreeAndNil(Grass);
    FreeAndNil(Tree);
    FreeAndNil(Image);

  end;

const
  Ancho: integer = 50;
  Alto: integer = 50;

var
  Map: Tmap;
begin
  Map := GenerateMap(Ancho, Alto);
  PrintMap(Map);
  SaveMapAsImage(Map, 'map.png');

end.
