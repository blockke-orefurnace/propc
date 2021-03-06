{------------------------------------------------------------}
{The MIT License (MIT)

 prOpc Toolkit
 Copyright (c) 2000, 2001 Production Robots Engineering Ltd

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.}
{------------------------------------------------------------}
unit OpcServerUnit;

interface

uses
  SysUtils, Classes, prOpcRttiServer, prOpcServer, prOpcTypes;

type
  TDemo11 = class(TRttiItemServer)
  private
    FIntegerData: array[0..4] of Integer;
    FDoubleData: array[0..4] of Double;
    FStringData: array[0..4] of String;
    function GetIntegerArray(i: Integer): Integer;
    function GetRealArray(i: Integer): Double;
    function GetStringArray(i: Integer): String;
    procedure SetIntegerArray(i: Integer; Value: Integer);
    procedure SetRealArray(i: Integer; Value: Double);
    procedure SetStringArray(i: Integer; const Value: String);
  protected
    procedure LoadRttiItems(Proxy: TObject); override;
  public
  published
  end;

implementation
uses
  prOpcError;

{ TDemo11 }


function TDemo11.GetIntegerArray(i: Integer): Integer;
begin
  Result:= FIntegerData[i]
end;

function TDemo11.GetRealArray(i: Integer): Double;
begin
  Result:= FDoubleData[i]
end;

function TDemo11.GetStringArray(i: Integer): String;
begin
  Result:= FStringData[i]
end;

procedure TDemo11.SetIntegerArray(i, Value: Integer);
begin
  FIntegerData[i]:= Value
end;

procedure TDemo11.SetRealArray(i: Integer; Value: Double);
begin
  FDoubleData[i]:= Value
end;

procedure TDemo11.SetStringArray(i: Integer; const Value: String);
begin
  FStringData[i]:= Value
end;

procedure TDemo11.LoadRttiItems(Proxy: TObject);
begin
  {it is essential to call the default implementation first. This will load
  any 'standard' rtti items}
  inherited LoadRttiItems(Proxy);

  {this array is defined with a syntax of asNone, so it will generate a single
   server item, IntegerData. This will be an array of 5 integers}
  DefineIntegerArrayProperty('IntegerData', 5, asNone, GetIntegerArray, SetIntegerArray);

  {this array is defined with a syntax of asComma, and will generate 5 server
   items thus:
   'DoubleData,0', 'DoubleData,1' .. 'DoubleData,4'}
  DefineRealArrayProperty('DoubleData', 5, asComma, GetRealArray, SetRealArray);

  {this array is defined with a syntax of asBrackets, and will generate 5 server
   items thus:
   'StringData[0]', 'StringData[1]' .. 'StringData[4]'}
  DefineStringArrayProperty('StringData', 5, asBrackets, GetStringArray, SetStringArray)
end;


const
  ServerGuid: TGUID = '{C12606C1-AA2F-48A2-9659-4E46F9EAA6B2}';
  ServerVersion = 1;
  ServerDesc = 'prOpcKit - Rtti Array Demo';
  ServerVendor = 'Production Robots Eng. Ltd.';


initialization
  RegisterOPCServer(ServerGUID, ServerVersion, ServerDesc, ServerVendor, TDemo11.Create)
end.
 