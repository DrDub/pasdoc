{
  Copyright 1998-2018 PasDoc developers.

  This file is part of "PasDoc".

  "PasDoc" is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version.

  "PasDoc" is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with "PasDoc"; if not, write to the Free Software
  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA

  ----------------------------------------------------------------------------
}

{ @abstract(Information about PasDoc and compilers version.) }
unit PasDoc_Versions;

{$I pasdoc_defines.inc}

interface

{ ---------------------------------------------------------------------------- }
{ Compiler Identification Constants }
{ ---------------------------------------------------------------------------- }

{ Nice compiler name.
  This is a function only because we can't nicely declare it as a constant.
  But this behaves like a constant, i.e. every time you call it
  it returns the same thing (as long as this is the same binary). }
function COMPILER_NAME: string;

const
  COMPILER_BITS =  {$ifdef CPU64} '64' {$else} '32' {$endif};

{$IFDEF LINUX}
  COMPILER_OS = 'Linux';
{$ENDIF}
{$IFDEF MSWINDOWS}
  COMPILER_OS = 'MSWindows';
{$ENDIF}
{$IFDEF BEOS}
  COMPILER_OS = 'BeOS';
{$ENDIF}
{$IFDEF QNX}
  COMPILER_OS = 'QNX';
{$ENDIF}
{$IFDEF AMIGA}
  COMPILER_OS = 'AmigaOS';
{$ENDIF}
{$IFDEF SUNOS}
  COMPILER_OS = 'SunOS';
{$ENDIF}
{$IFDEF GO32V2}
  COMPILER_OS = 'DOS/Go32v2';
{$ENDIF}
{$IFDEF OS2}
  COMPILER_OS = 'OS/2';
{$ENDIF}
{$IFDEF FREEBSD}
  COMPILER_OS = 'FreeBSD';
{$ENDIF}
{$IFDEF DARWIN}
  COMPILER_OS = 'Darwin';
{$ENDIF}

  { ---------------------------------------------------------------------------- }
  { PasDoc Version Constants }
  { ---------------------------------------------------------------------------- }

  {  }
  PASDOC_NAME = 'PasDoc';

  { Date of last pasdoc release.

    We used to have this constant set to CVS/SVN @code($ Date) keyword, but:
    @unorderedList(
      @item(That's not a really correct indication of pasdoc release.
        @code($ Date) is only the date when this file, @code(PasDoc_Base.pas),
        was last modified.

        As it happens, always when you make an official release
        you have to manually change PASDOC_VERSION constant
        in this file below. So PASDOC_DATE was
        (at the time when the official release was made) updated to current date.
        But, since you have to change PASDOC_VERSION constant manually
        anyway, then it's not much of a problem to also update PASDOC_DATE
        manually.

        For unofficial releases (i.e. when pasdoc is simply compiled from SVN
        by anyone, or when it's packaged for
        [https://github.com/pasdoc/pasdoc/wiki/DevelopmentSnapshots]),
        PASDOC_DATE has no clear meaning. It's not the date of this
        release (since you don't update the PASDOC_VERSION constant)
        and it's not the date of last official release (since some
        commits possibly happened to @code(PasDoc_Base.pas) since
        last release).
      )

      @item(SVN makes this date look bad for the purpose of
        PASDOC_FULL_INFO. It's too long: contains the time,
        day of the week, and a descriptive version. Like
        @preformatted(2006-11-15 07:12:34 +0100 (Wed, 15 Nov 2006))

        Moreover, it contains indication of local user's system time,
        and the words (day of the week and month's name) are
        localized. So it depends on the locale developer has set
        (you can avoid localization of the words by doing things like
        @code(export LANG=C) before SVN operations, but it's too
        error-prone).
      )
    )
  }
  PASDOC_DATE = '2021-02-07';
  { }
  PASDOC_VERSION = '0.16.0';
  { }
  PASDOC_NAME_AND_VERSION = PASDOC_NAME + ' ' + PASDOC_VERSION;
  { }
  PASDOC_HOMEPAGE = 'https://pasdoc.github.io/';

{ Returns pasdoc name, version, used compiler version, etc.

  This is a function only because we can't nicely declare it as a constant.
  But this behaves like a constant, i.e. every time you call it
  it returns the same thing (as long as this is the same binary). }
function PASDOC_FULL_INFO: string;

implementation

uses SysUtils;

function COMPILER_NAME: string;
begin
  COMPILER_NAME :=
    {$IFDEF FPC}
    'FPC ' + Format('%d.%d.%d', [FPC_VERSION, FPC_RELEASE, FPC_PATCH]);
    {$define COMPILER_VERSION_DEFINED}
    {$ENDIF}

    {$IFDEF KYLIX_1}   'KYLIX 1';      {$define COMPILER_VERSION_DEFINED} {$ENDIF}
    {$IFDEF KYLIX_2}   'KYLIX 2';      {$define COMPILER_VERSION_DEFINED} {$ENDIF}
    {$IFDEF KYLIX_3}   'KYLIX 3';      {$define COMPILER_VERSION_DEFINED} {$ENDIF}

    {$IFDEF DELPHI_6_UP}
    Format('DELPHI (Compiler Version %2.1f)', [CompilerVersion]);
    {$define COMPILER_VERSION_DEFINED}
    {$ENDIF}

    {$IFDEF DELPHI_5}  'DELPHI 5';     {$define COMPILER_VERSION_DEFINED} {$ENDIF}
    {$IFDEF DELPHI_4}  'DELPHI 4';     {$define COMPILER_VERSION_DEFINED} {$ENDIF}
    {$IFDEF DELPHI_3}  'DELPHI 3';     {$define COMPILER_VERSION_DEFINED} {$ENDIF}
    {$IFDEF DELPHI_2}  'DELPHI 2';     {$define COMPILER_VERSION_DEFINED} {$ENDIF}
    {$IFDEF DELPHI_1}  'DELPHI 1';     {$define COMPILER_VERSION_DEFINED} {$ENDIF}

    {$IFNDEF COMPILER_VERSION_DEFINED}
    'UNKNOWN';
    {$ENDIF}

  {$undef COMPILER_VERSION_DEFINED} { symbol no longer needed }
end;

function PASDOC_FULL_INFO: string;
begin
  PASDOC_FULL_INFO :=
    PASDOC_NAME_AND_VERSION + ' [' + PASDOC_DATE + '|' +
      COMPILER_NAME + '|' + COMPILER_OS + '|' + COMPILER_BITS + ']';
end;

end.
