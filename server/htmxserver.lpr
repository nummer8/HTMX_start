program htmxserver;

{$mode objfpc}{$H+}

uses
  SysUtils,
  fpwebfile,
  fpmimetypes,
  fphttpapp,
  httproute,
  httpdefs;

const
  MyMime = '/etc/mime.types';

var
  aDir: string;

  procedure apiEndpoint(aRequest: TRequest; aResponse: TResponse);
  begin
    aResponse.content := '<h1>HTMX WORKING!</h1>';
    aResponse.Code := 200;
    aResponse.ContentType := 'text/html; charset=utf-8';
    aResponse.ContentLength := length(aResponse.Content);
    aResponse.SendContent;
  end;

  procedure ctrlEndpoint(aRequest: TRequest; aResponse: TResponse);
  begin
    aResponse.content := '<h1>Ctrl Clicked!</h1>';
    aResponse.Code := 200;
    aResponse.ContentType := 'text/html; charset=utf-8';
    aResponse.ContentLength := length(aResponse.Content);
    aResponse.SendContent;
  end;

  procedure mouseEndpoint(aRequest: TRequest; aResponse: TResponse);
  begin
    aResponse.content := '<h1>Mouse entered the div</h1>';
    aResponse.Code := 200;
    aResponse.ContentType := 'text/html; charset=utf-8';
    aResponse.ContentLength := length(aResponse.Content);
    aResponse.SendContent;
  end;


begin
  MimeTypes.LoadKnownTypes;
  Application.Title := 'HTMX demo server';
  Application.Port := 3000;
  MimeTypesFile := MyMime;
  Application.Initialize;
  if Application.HasOption('d', 'directory') then
    aDir := Application.GetOptionValue('d', 'directory')
  else
    aDir := ExtractFilePath(ParamStr(0)) + '..\webwidget\';
  aDir := ExpandFileName(aDir);
  RegisterFileLocation('webwidget', aDir);
  HTTPRouter.RegisterRoute('/api', @apiEndpoint, False);
  HTTPRouter.RegisterRoute('/ctrl', @ctrlEndpoint, False);
  HTTPRouter.RegisterRoute('/mouse', @mouseEndpoint, False);

  Writeln('open a webbrowser: ' + Application.HostName + ':' + IntToStr(
    Application.port) + '/webwidget/index.html');

  Application.Run;

end.
