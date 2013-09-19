unit MainUI;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Menus, leptonica, LibLeptUtils, pageviewer, types, LCLType,
  ActnList, Buttons, ComCtrls,
  OcrivistData, selector,
  {$IFDEF HAS_LIBSANE} Sane, scansane,{$ENDIF}
  {$IFDEF MSWINDOWS} DelphiTwain, scantwain,{$ENDIF}
  ocreditor;

{ command line for converting pdf pages to tiff:
  convert -density 300x300 -compress lzw <source>.pdf[0] <output>.tiff

  to get number of pages:
  pdfinfo <source>.pdf | grep Pages
}

type

  { TMainForm }

  TMainForm = class ( TForm )
    AutoselectButton: TToolButton;
    ContrastMenuItem: TMenuItem;
    DeskewButton: TToolButton;
    EditMenu: TMenuItem;
    FileExportMenu: TMenuItem;
    FileDjVuMenuItem: TMenuItem;
    FilePDFMenuItem: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    EnhanceMenuItem: TMenuItem;
    FitHeightButton: TToolButton;
    FitWidthButton: TToolButton;
    LanguageComboBox: TComboBox;
    DeskewMenuItem: TMenuItem;
    CorrectionviewImage: TImage;
    ImageList1: TImageList;
    ImportMenuItem: TMenuItem;
    CopyTextMenuItem: TMenuItem;
    MenuItem4: TMenuItem;
    HelpMenu: TMenuItem;
    AboutMenuItem: TMenuItem;
    DebugMenuItem: TMenuItem;
    FileTextMenuItem: TMenuItem;
    miThreshold: TMenuItem;
    RightSidePanel: TPanel;
    ScanSettingsMenuItem: TMenuItem;
    NewProjectMenuItem: TMenuItem;
    OCRScreenMenuItem: TMenuItem;
    ModeMenuItem: TMenuItem;
    ProcessPageMenuItem: TMenuItem;
    LanguagePanel: TPanel;
    Rotate180MenuItem: TMenuItem;
    miAutoProcessPage: TMenuItem;
    miReadPage: TMenuItem;
    miAnalysePage: TMenuItem;
    miAutoAll: TMenuItem;
    OCRMenu: TMenuItem;
    RotateLeftTButton: TToolButton;
    RotateRightButton: TToolButton;
    SaveTextMenuItem: TMenuItem;
    DeleteLineMenuItem: TMenuItem;
    CorrectionPanel: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    CorrectionviewScrollBox: TScrollBox;
    SpellcheckButton: TToolButton;
    Splitter2: TSplitter;
    TesseractButton: TToolButton;
    TextPopupMenu: TPopupMenu;
    pagecountLabel: TLabel;
    MenuItem1: TMenuItem;
    RotateRMenuItem: TMenuItem;
    RotateLMenuItem: TMenuItem;
    SetScannerMenuItem: TMenuItem;
    MenuItem2: TMenuItem;
    StatusBar: TStatusBar;
    ThumbnailListBox: TListBox;
    MainMenu: TMainMenu;
    FileMenu: TMenuItem;
    LoadPageMenuItem: TMenuItem;
    DelPageMenuItem: TMenuItem;
    PageMenu: TMenuItem;
    ScanPageMenuItem: TMenuItem;
    SaveAsMenuItem: TMenuItem;
    SaveDialog: TSaveDialog;
    SaveProjectMenuItem: TMenuItem;
    OpenProjectMenuItem: TMenuItem;
    ExitMenuItem: TMenuItem;
    FitHeightMenuItem: TMenuItem;
    FitWidthMenuItem: TMenuItem;
    MainToolBar: TToolBar;
    AddPageButton: TToolButton;
    PageToolBar: TToolBar;
    TextToolBar: TToolBar;
    ToolButton1: TToolButton;
    SaveButton: TToolButton;
    DelPageButton: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    DjvuButton: TToolButton;
    SelTextButton: TToolButton;
    DelSelectButton: TToolButton;
    CropButton: TToolButton;
    ToolButton5: TToolButton;
    PDFToolButton: TToolButton;
    TextButton: TToolButton;
    ScanPageButton: TToolButton;
    ToolButton6: TToolButton;
    UnsharpMenuItem: TMenuItem;
    View25MenuItem: TMenuItem;
    View100MenuItem: TMenuItem;
    View75MenuItem: TMenuItem;
    View50MenuItem: TMenuItem;
    ViewMenu: TMenuItem;
    MenuItem3: TMenuItem;
    OpenDialog: TOpenDialog;
    ListboxPanel: TPanel;
    OCRPanel: TPanel;
    MainPanel: TPanel;
    Splitter1: TSplitter;
    procedure AboutMenuItemClick ( Sender: TObject ) ;
    procedure CopyTextMenuItemClick ( Sender: TObject ) ;
    procedure CropButtonClick ( Sender: TObject ) ;
    procedure DebugMenuItemClick ( Sender: TObject ) ;
    procedure DelPageMenuItemClick ( Sender: TObject ) ;
    procedure DelSelectButtonClick ( Sender: TObject ) ;
    procedure ExitMenuItemClick ( Sender: TObject ) ;
    procedure ExportModeMenuClick ( Sender: TObject ) ;
    procedure FormCreate ( Sender: TObject ) ;
    procedure FormDestroy ( Sender: TObject ) ;
    procedure FormKeyDown ( Sender: TObject; var Key: Word; Shift: TShiftState
      ) ;
    procedure ImportMenuItemClick ( Sender: TObject ) ;
    procedure LanguageComboBoxChange(Sender: TObject);
    procedure LoadModeOptionClick(Sender: TObject);
    procedure miThresholdClick ( Sender: TObject ) ;
    procedure MenuItem6Click ( Sender: TObject ) ;
    procedure miAutoAllClick ( Sender: TObject ) ;
    procedure miAutoProcessPageClick ( Sender: TObject ) ;
    procedure ModeChange ( Sender: TObject ) ;
    procedure NewProjectMenuItemClick ( Sender: TObject ) ;
    procedure PDFToolButtonClick(Sender: TObject);
    procedure RotateButtonClick ( Sender: TObject ) ;
    procedure DjvuButtonClick ( Sender: TObject ) ;
    procedure DeskewButtonClick ( Sender: TObject ) ;
    procedure SaveButtonClick ( Sender: TObject ) ;
    procedure SaveTextMenuItemClick ( Sender: TObject ) ;
    procedure ScanSettingsMenuItemClick ( Sender: TObject ) ;
    procedure SelTextButtonClick ( Sender: TObject ) ;
    procedure AnalyseButtonClick ( Sender: TObject ) ;
    procedure SpellcheckButtonClick ( Sender: TObject ) ;
    procedure TextButtonClick(Sender: TObject);
    procedure ThumbnailListBoxDragDrop ( Sender, Source: TObject; X, Y: Integer
      ) ;
    procedure ThumbnailListBoxDragOver ( Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean ) ;
    procedure ThumbnailListBoxMouseDown ( Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer ) ;
    procedure ThumbnailListBoxMouseUp ( Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer ) ;
    procedure UpdateScannerStatus ( Sender: TObject ) ;
    procedure ThumbnailListBoxClick ( Sender: TObject ) ;
    procedure ThumbnailListBoxDrawItem ( Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState ) ;
    procedure LoadPageMenuItemClick ( Sender: TObject ) ;
    procedure OpenProjectMenuItemClick ( Sender: TObject ) ;
    procedure SaveAsMenuItemClick ( Sender: TObject ) ;
    procedure ScanPageMenuItemClick ( Sender: TObject ) ;
    procedure SetScannerMenuItemClick ( Sender: TObject ) ;
    procedure TesseractButtonClick ( Sender: TObject ) ;
    procedure ViewMenuItemClick ( Sender: TObject ) ;
  private
    { private declarations }
    Editor: TOcrivistEdit;
    AddingThumbnail: Boolean;
    ThumbnailStartPoint: TPoint;
    DraggingThumbnail: Boolean;
    MultiSelecting: Boolean;
    ScanCancelled: Boolean;
    DjvuCancelled: Boolean;
    procedure CancelScan ( Sender: TObject );
    procedure CancelDjVu ( Sender: TObject );
    procedure MakeSelection ( Sender: TObject );
    procedure DeleteSelection ( Sender: TObject );
    procedure SelectionChange ( Sender: TObject );
    procedure UpdateThumbnail ( Sender: TObject );
    procedure ShowScanProgress( progress: Single );
    procedure ShowOCRProgress ( progress: Single );
    Procedure ShowSaveProgress(Sender : TObject; Const Pct : Double);
    procedure LoadPage( newpage: PLPix; pageindex: integer );
    procedure DoCrop;
    function AnalysePage(pageindex: integer): integer;
    procedure OCRPage(pageindex: integer);
    procedure DoSpellcheck;
    procedure EditorSelectToken( aline, aword: integer );
    function PopulateLanguageList: Integer;
  public
    { public declarations }
  end;



const
  THUMBNAIL_HEIGHT = 100;

  TEMPFILE_HIDDEN_TEXT = 'ocr-temp.txt';
  TEMPFILE_DJVU_PAGE = 'ocr-temp.djvu';
  TEMPFILE_SINGLEBIT_IMAGE = 'ocr-temp.pnm';
  TEMPFILE_MULTIBIT_IMAGE = 'ocr-temp.pbm';

var
  MainForm: TMainForm;
  ICanvas : TPageViewer;
  CorrectionviewImage:TImage;
  OCRProgressCount: integer;
  OCRLanguage: string;
  OCRDatapath: string;
  HasDJVU: Boolean;
  undoPix: PLPix;

  AutoDeskewOnScan: Boolean;

 implementation

  uses DjvuUtils, scanner, {$IFDEF HAS_LIBSANE} scanselect, {$ENDIF} ocr, Clipbrd, progress, about{, threshold};

  {$R *.lfm}

{ TMainForm }


procedure TMainForm.CropButtonClick ( Sender: TObject ) ;
begin
  ICanvas.SelectionMode := smCrop;  writeln('crop button');
  StatusBar.Panels[0].Text := 'CROP';
  //SelectToolButton.ImageIndex := TMenuItem(Sender).ImageIndex;
end;

procedure TMainForm.DebugMenuItemClick ( Sender: TObject ) ;
var
  x: Integer;
begin
  {for x := 0 to CurrentProject.PageCount-1 do
     if CurrentProject.Pages[x].Active then writeln('page ', x+1, ': ACTIVE')
     else writeln('page ', x+1, ': DISACTIVATED');}
  ShowMessage(Format( 'pageimage%.3d.tif', [5] ));
end;

procedure TMainForm.CopyTextMenuItemClick ( Sender: TObject ) ;
begin
  Clipboard.AsText := Editor.Text;
end;

procedure TMainForm.AboutMenuItemClick ( Sender: TObject ) ;
begin
  AboutForm.ShowModal;
end;

procedure TMainForm.DelPageMenuItemClick ( Sender: TObject ) ;
var
  DelPage: LongInt;
  NewPage: Integer;
begin
  if ThumbnailListBox.ItemIndex<0 then exit;
  DelPage := ThumbnailListBox.ItemIndex;
  NewPage := 0;
  if MessageDlg('Confirm delete page',
                'Are you sure that you want to delete page ' + IntToStr(DelPage+1) + ' ?',
                mtConfirmation,
                mbYesNoCancel, 0)=mrYes then
                begin
                  if ThumbnailListBox.Count>1 then
                     begin
                       if DelPage>0 then NewPage := DelPage-1
                       else NewPage := 0;
                     end
                  else NewPage := -1;
                  ThumbnailListBox.Items.Delete(DelPage);
                  ThumbnailListBox.ItemIndex := NewPage;
                  CurrentProject.DeletePage(DelPage);
                  if ThumbnailListBox.Count>0
                     then ThumbnailListBoxClick(ThumbnailListBox)
                     else ICanvas.Picture := nil;
                  if ThumbnailListBox.Count>1
                   then pagecountLabel.Caption := Format('%d pages', [ThumbnailListBox.Count])
                   else pagecountLabel.Caption := #32;  // if label is empty it changes its height
                  DelPageButton.Enabled := ThumbnailListBox.Count>0;
                end;
end;

procedure TMainForm.DelSelectButtonClick ( Sender: TObject ) ;
begin
  ICanvas.SelectionMode := smDelete;
  StatusBar.Panels[0].Text := 'DELETE';
  //SelectToolButton.ImageIndex := TMenuItem(Sender).ImageIndex;
end;

procedure TMainForm.ExitMenuItemClick ( Sender: TObject ) ;
begin
  Close;
end;

procedure TMainForm.ExportModeMenuClick ( Sender: TObject ) ;
begin
  case TComponent(Sender).Tag of
       0: DjvuButton.OnClick := @DjvuButtonClick;
  end;
  DjvuButton.ImageIndex := TMenuItem(Sender).ImageIndex;
end;

procedure TMainForm.FormCreate ( Sender: TObject ) ;
var
  x: Integer;
begin
  ICanvas := TPageViewer.Create(self);
  ICanvas.Parent := MainPanel;
  ICanvas.Align := alClient;
  Icanvas.OnSelect := @MakeSelection;
  Icanvas.OnDeleteSelection := @DeleteSelection;
  ICanvas.OnChangeBitmap := @UpdateThumbnail;
  OCRPanel.Align := alClient;
  ThumbnailListBox.Clear;
  ThumbnailListBox.ItemIndex := -1;
  ThumbnailListBox.ItemHeight := THUMBNAIL_HEIGHT + ThumbnailListBox.Canvas.TextHeight('Yy')+2;
  {$IFDEF LINUX}
  OCRDatapath := '/usr/local/share/tessdata/';
  {$ENDIF}
  {$IFDEF MSWINDOWS}
  OCRDatapath := 'C:\Program Files\Tesseract-OCR\tessdata\';
  {$ENDIF}
  if PopulateLanguageList<1 then
    begin
      TesseractButton.Enabled := false;
      OCRMenu.Enabled := false;
    end;

  OCRLanguage := 'eng';
  LanguageComboBox.ItemIndex :=
             LanguageComboBox.Items.IndexOf(GetLanguageFromToken(OCRLanguage));
  {$IFNDEF HAS_LIBSANE}
  ScanPageButton.Visible := false;
  ScanPageMenuItem.Visible := false;
  SetScannerMenuItem.Enabled := false;
  {$Endif}
  {$IFDEF MSWINDOWS}
  ScanPageButton.Visible := true;
  ScanPageButton.Enabled := IsTwainInstalled;
  SetScannerMenuItem.Enabled := IsTwainInstalled;
  ScanPageMenuItem.Visible := true;
  {$ENDIF}
  CurrentProject := TOcrivistProject.Create;
  CurrentProject.Title := 'Untitled';
  CurrentProject.OnSaveProgress := @ShowSaveProgress;
  AddingThumbnail := false;
  DraggingThumbnail := false;
  Editor := TOcrivistEdit.Create(Self);
  editor.Parent := Panel3;
  editor.Align := alClient;
  Editor.PopupMenu := TextPopupMenu;
  Editor.OnSelectToken := @EditorSelectToken;
  DjVuPath := SearchFileInPath('djvumake','',
                   SysUtils.GetEnvironmentVariable('PATH'),PathSeparator,[]);
  if Length(DjVuPath)>0
     then DjVuPath := ExtractFilePath(DjVuPath);
  {$IFDEF MSWINDOWS}
  if Length(DjVuPath)=0
    then if FileExists('C:\Program Files\DjvuLibre\djvumake.exe')
        then DjVuPath := 'C:\Program Files\DjvuLibre\';
  {$ENDIF}
  HasDJVU := (DjVuPath<>'');
  DjvuButton.Enabled := HasDJVU;
  FileDjVuMenuItem.Enabled := HasDJVU;
  if HasDJVU then DjVuPath := IncludeTrailingPathDelimiter(DjVuPath);
  AutoDeskewOnScan := true;
  SelTextButtonClick(SelTextButton);
  SpellcheckButton.Enabled := Editor.HasSpellCheck;
end;

procedure TMainForm.FormDestroy ( Sender: TObject ) ;
var
  x: Integer;
  Folder: String;
begin
  {for x := 0 to ThumbnailListBox.Items.Count-1 do
    TBitmap(ThumbnailListBox.Items.Objects[x]).Free;}  //NB: these are now freed by TOcrivistPage;
  Folder := CurrentProject.WorkFolder;
  if Assigned(CurrentProject)
    then FreeAndNil( CurrentProject );
  if DeleteDirectory(Folder,True)
      then RemoveDirUTF8(Folder);
  {$IFDEF HAS_LIBSANE}
  if Assigned(ScannerHandle) then
      begin
        sane_close(ScannerHandle);
        sane_exit;
      end;
  if PDevices <> nil then Freemem(PDevices);
  {$ENDIF}
end;

procedure TMainForm.FormKeyDown ( Sender: TObject; var Key: Word;
  Shift: TShiftState ) ;
begin
  if ICanvas.SelectionMode=smCrop then
     begin
       if Key=27 then begin SelTextButtonClick(SelTextButton); ICanvas.ClearSelection; end
      else if Key=13 then begin DoCrop; SelTextButtonClick(SelTextButton); end;
     end;
  if ssCtrl in Shift then if Key=77 then
     begin
       writeln('Key detected: ', Key);
       if OCRScreenMenuItem.Checked
        then ProcessPageMenuItem.Click
        else OCRScreenMenuItem.Click;
       Key := 0;
     end;
end;

procedure TMainForm.ImportMenuItemClick ( Sender: TObject ) ;
var
  pages: LongInt;
  x: Integer;
  newpage: PLPix;
  pagename: String;
  tempfile: String;
begin
  with OpenDialog do
       begin
         DefaultExt := '.djvu';
         Filter := 'DJVU files|*.djvu|All Files|*';
         Title := 'Import pages from DJVU file';
       end;
  if OpenDialog.Execute then
    begin
      pages := djvuGetDocInfo(OpenDialog.FileName).PageCount;
      if pages>0 then
        begin
          CurrentProject.Clear;
          ThumbnailListBox.Clear;
          ProgressForm.MainTextLabel.Caption := 'Importing DJVU file: ' + ExtractFileName( OpenDialog.FileName ) +#10
           + '(' + IntToStr(pages) + ' pages)';
          ProgressForm.Show(nil);
          Enabled := false;
        end;
      for x := 1 to pages do
         begin
           newpage := nil;
           ProgressForm.SetUpdateText('Importing page ' + IntToStr(x));
           Application.ProcessMessages;
           tempfile := '/tmp/temppage.tif';
           if FileExistsUTF8(tempfile) then DeleteFileUTF8(tempfile);
           if djvuExtractPage(OpenDialog.FileName, tempfile, x)
              then newpage := pixRead( PChar(tempfile) );
           if newpage <> nil then
             begin
               pagename :=  ExtractFileNameOnly(OpenDialog.FileName)+IntToStr(x);
               pixSetText(newpage, PChar(pagename));
               LoadPage(newpage, ThumbnailListBox.ItemIndex+1);
           //    if x>2 then CurrentProject.Pages[x-2].Active := false;
             end;
           if FileExistsUTF8(tempfile) then DeleteFileUTF8(tempfile);
         end;
      ProgressForm.Hide;
      Enabled := true;
    end;
    StatusBar.Panels[1].Text := '';
end;

procedure TMainForm.LanguageComboBoxChange(Sender: TObject);
begin
  OCRLanguage := GetLanguageToken(LanguageComboBox.Items[LanguageComboBox.ItemIndex]);
end;

procedure TMainForm.LoadModeOptionClick(Sender: TObject);
begin
  case TMenuItem(Sender).Tag of
       0: AddPageButton.OnClick := @LoadPageMenuItemClick;
       1: AddPageButton.OnClick := @ScanPageMenuItemClick;
  end;
  AddPageButton.ImageIndex := TMenuItem(Sender).ImageIndex;
  AddPageButton.Hint := TMenuItem(Sender).Hint;
end;

procedure TMainForm.miThresholdClick ( Sender: TObject ) ;
begin
   {undoPix := ICanvas.Picture;
   CurrentProject.CurrentPage.PageImage := pixThresholdToBinary(ICanvas.Picture, StrToInt(ThresholdEdit.Text));}
{  ThresholdForm:= TThresholdForm.Create(nil);
  if ThresholdForm.ShowModal=mrOK
   then CurrentProject.CurrentPage.PageImage := pixThresholdToBinary(ICanvas.Picture, ThresholdForm.ThreshTrackBar.Position);
  ThresholdForm.Free;}
end;

procedure TMainForm.MenuItem6Click ( Sender: TObject ) ;
begin
  if undoPix<>nil then CurrentProject.CurrentPage.PageImage := undoPix;
end;

procedure TMainForm.miAutoAllClick ( Sender: TObject ) ;
var
  x: Integer;
begin
  if CurrentProject.PageCount<1 then Exit;
  for x := 0 to CurrentProject.PageCount-1 do
     begin
       AnalysePage(x);
       OCRPage(x);
     end;
  Editor.OCRData := CurrentProject.CurrentPage.OCRData;
end;

procedure TMainForm.miAutoProcessPageClick ( Sender: TObject ) ;
begin
  if AnalysePage(ThumbnailListBox.ItemIndex)>0 then
    begin
      ThumbnailListBoxClick(ThumbnailListBox);
      OCRPage(ThumbnailListBox.ItemIndex);
      Editor.OCRData := CurrentProject.CurrentPage.OCRData;
    end;
end;

procedure TMainForm.ModeChange ( Sender: TObject ) ;
begin
  TMenuItem(Sender).Checked := true;
  if Sender=ProcessPageMenuItem then
     begin
       MainPanel.Visible := true;
       OCRPanel.Visible := false;
     end;
  Application.ProcessMessages;
  OCRPanel.Visible := OCRScreenMenuItem.Checked;
  MainPanel.Visible := ProcessPageMenuItem.Checked;
  if MainPanel.Visible then writeln('MainPanel.Visible')
  else WriteLn('MainPanel not visible');
end;

procedure TMainForm.NewProjectMenuItemClick ( Sender: TObject ) ;
begin
  CurrentProject.Free;
  CurrentProject := TOcrivistProject.Create;
  CurrentProject.OnSaveProgress := @ShowSaveProgress;
  ThumbnailListBox.Clear;
  ICanvas.Picture := nil;
  editor.Clear;
end;

procedure TMainForm.PDFToolButtonClick(Sender: TObject);
var
  sourcefiles: TSArray;
  p: Integer;
begin
  with SaveDialog do
       begin
         DefaultExt := '.pdf';
         Filter := 'PDF Files|*.pdf|All Files|*';
         Title := 'Export project as PDF file';
         FileName := CurrentProject.Title;
       end;
  if SaveDialog.Execute then
      try
        Enabled := false;
        sourcefiles.refcount := 1;
        SetLength(sourcefiles.strarray, CurrentProject.PageCount+1);
        sourcefiles.n := CurrentProject.PageCount+1;
        sourcefiles.nalloc := CurrentProject.PageCount;
        for p := 0 to CurrentProject.PageCount-1 do
           sourcefiles.strarray[p] := PChar(CurrentProject.Pages[p].Filename);
        saConvertFilesToPdf(@sourcefiles, 0, 1, 90,
                             PChar(CurrentProject.Title),
                             PChar(SaveDialog.FileName));
      finally
        Enabled := True;
      end;
end;

procedure TMainForm.RotateButtonClick ( Sender: TObject ) ;
var
  newpix: PLPix;
  oldpix: PLPix;
  direction: LongInt;
begin
 if CurrentProject.CurrentPage=nil then exit;
 direction := 0;
 newpix := nil;
 oldpix := CurrentProject.CurrentPage.PageImage;

 if (Sender=RotateLeftTButton) or (Sender=RotateLMenuItem)
    then direction := -1
 else if (Sender=RotateRightButton) or (Sender=RotateRMenuItem)
    then direction := 1;
 if direction<>0
    then newpix := pixRotate90(oldpix, direction)
 else newpix := pixRotate180(nil, oldpix);   //Sender=Rotate180MenuItem;
 if newpix<>nil then
    begin
      if oldpix <> nil then pixDestroy(@oldpix);
      CurrentProject.CurrentPage.PageImage := newpix;
      ICanvas.Picture := newpix;
    end;
end;

procedure TMainForm.DjvuButtonClick ( Sender: TObject ) ;
var
  p: PLPix;
  d: LongInt;
  w, h: Longint;
  fn: String;
  HiddenText: PChar;
  x: Integer;
  data: TStringList;
  lin: TLineData;
  lline: Integer;
  wword: Integer;
  messagetext: String;

  function DjvuescapeText( inStr: string ): string;
  var
    cc: Integer;
  begin
    for cc := length(inStr) downto 1 do
       begin
         if inStr[cc]='"'
            then insert('\', inStr, cc)
         else if inStr[cc]='\'
            then insert('\', inStr, cc)
         else if inStr[cc]<#31
            then Delete(inStr, cc, 1);
       end;
    Result := inStr;
  end;
begin
 DjvuCancelled := false;
 with SaveDialog do
      begin
        DefaultExt := '.djvu';
        Filter := 'Djvu Files|*.djvu|All Files|*';
        Title := 'Export project to djvu...';
        FileName := CurrentProject.Title;
      end;
 if SaveDialog.Execute then
     try
       Enabled := false;
       ProgressForm.SetMainText('Exporting project to Djvu');
       ProgressForm.Show(@CancelDjVu);
       if FileExistsUTF8(SaveDialog.FileName)
             then DeleteFileUTF8(SaveDialog.FileName);
       for x := 0 to CurrentProject.PageCount-1 do
          try
            HiddenText := nil;
            data := TStringList.Create;
            data.Add('select; remove-txt');
            data.Add('# -------------------------------------');
            data.Add('select 1');
            data.Add('set-txt');

            p := CurrentProject.Pages[x].PageImage;
            pixGetDimensions(p, @w, @h, @d);
            if d=1
                then fn :=  TEMPFILE_SINGLEBIT_IMAGE
                else fn := TEMPFILE_MULTIBIT_IMAGE;
            messagetext := 'Processing page ' + IntToStr(x+1);
            ProgressForm.SetUpdateText( messagetext );
            if CurrentProject.Pages[x].OCRData <> nil then
               begin
                  data.Add(Format('(page 0 0 %d %d', [w, h]));
                  for lline := 0 to CurrentProject.Pages[x].OCRData.Linecount-1 do
                     if CurrentProject.Pages[x].OCRData.Lines[lline].WordCount>0 then
                     begin
                       lin := CurrentProject.Pages[x].OCRData.Lines[lline];
                       data.Add( Format(' (line %d %d %d %d', [lin.Box.Left,
                                                               h-lin.Box.Bottom,
                                                               lin.Box.Right,
                                                               h-lin.Box.Top]));
                       for wword := 0 to lin.WordCount-1 do
                           data.Add( Format('  (word %d %d %d %d "%s")', [lin.Words[wword].Box.Left,
                                                               h-lin.Words[wword].Box.Bottom,
                                                               lin.Words[wword].Box.Right,
                                                               h-lin.Words[wword].Box.Top,
                                                               DjvuescapeText( lin.Words[wword].Text )] ));
                       data.Strings[data.Count-1] := data.Strings[data.Count-1] + ')';
                     end;
                  data.Strings[data.Count-1] := data.Strings[data.Count-1] + ')';
                  HiddenText := TEMPFILE_HIDDEN_TEXT;
                  data.SaveToFile(HiddenText);
               end;
            Application.ProcessMessages;
            if DjvuCancelled then exit;
            pixWrite(PChar(fn), p, IFF_PNM);
            ProgressForm.SetUpdateText( messagetext + ': Creating page');
            if djvumakepage(fn, TEMPFILE_DJVU_PAGE, HiddenText)=0 then
               begin
                 Application.ProcessMessages;
                 if DjvuCancelled then exit;
                 ProgressForm.SetUpdateText( messagetext + ': Adding page to document');
                 djvuaddpage(SaveDialog.FileName, TEMPFILE_DJVU_PAGE);
               end
            else ShowMessage('Error when encoding page ' + IntToStr(x+1));
            Application.ProcessMessages;
            if DjvuCancelled then exit;
          finally
            StatusBar.Panels[1].Text := '';
            data.Free;
            DeleteFileUTF8(fn);
            DeleteFileUTF8(HiddenText);
            DeleteFileUTF8(TEMPFILE_DJVU_PAGE);
          end;
     finally
       ProgressForm.Hide;
       Enabled := true;
       if DjvuCancelled then ShowMessage('Operation cancelled');
     end;
end;

procedure TMainForm.DeskewButtonClick ( Sender: TObject ) ;
var
  oldpix: PLPix;
  newpix: PLPix;
begin
  if CurrentProject.CurrentPage=nil then exit;
  newpix := nil;
  oldpix := CurrentProject.CurrentPage.PageImage;
  newpix := pixDeskew(oldpix, 0);
  if newpix<>nil then
     begin
       ICanvas.Picture := newpix;
       CurrentProject.CurrentPage.PageImage := newpix;
       if oldpix<>nil then pixDestroy(@oldpix);
     end;
end;

procedure TMainForm.SaveButtonClick ( Sender: TObject ) ;
var
  x: Integer;
   I: Integer;
begin
  if CurrentProject.Filename=''
     then SaveAsMenuItemClick(Sender)
  else
    begin
      CurrentProject.SaveToFile(CurrentProject.Filename);
    end;
end;

procedure TMainForm.SaveTextMenuItemClick ( Sender: TObject ) ;
begin
 with SaveDialog do
      begin
        DefaultExt := '.txt';
        Filter := 'All Files|*';
        Title := 'Save page text as ...';
      end;
  if SaveDialog.Execute then
     begin
       Editor.Lines.SaveToFile(SaveDialog.FileName);
     end;
end;

procedure TMainForm.ScanSettingsMenuItemClick ( Sender: TObject ) ;
begin
 ScannerForm.ShowModal;
end;

procedure TMainForm.SelTextButtonClick ( Sender: TObject ) ;
begin
  ICanvas.SelectionMode := smSelect;
  StatusBar.Panels[0].Text := 'SELECT';
  SelTextButton.Down := true;
  //SelectToolButton.ImageIndex := TMenuItem(Sender).ImageIndex;
end;

procedure TMainForm.AnalyseButtonClick ( Sender: TObject ) ;
begin
 if AnalysePage(ThumbnailListBox.ItemIndex)>0
  then ThumbnailListBoxClick(ThumbnailListBox);
end;

procedure TMainForm.SpellcheckButtonClick ( Sender: TObject ) ;
begin
  DoSpellcheck;
end;

procedure TMainForm.TextButtonClick(Sender: TObject);
var
   OutFile: Text;
   p: Integer;
begin
 with SaveDialog do
      begin
        DefaultExt := '.txt';
        Filter := 'Text Files|*.txt|All Files|*';
        Title := 'Save recognised text to file';
        FileName := CurrentProject.Title;
      end;
 if SaveDialog.Execute then
     begin
       AssignFile(OutFile, SaveDialog.FileName);
       try
         Rewrite(OutFile);
         for p := 0 to CurrentProject.PageCount-1 do
            WriteLn(OutFile, CurrentProject.Pages[p].Text);
       finally
         CloseFile(OutFile);
       end;
     end;
end;

procedure TMainForm.ThumbnailListBoxDragDrop ( Sender, Source: TObject; X,
  Y: Integer ) ;
var
    DropPosition, StartPosition: Integer;
    DropPoint: TPoint;
 begin
    DropPoint.X := X;
    DropPoint.Y := Y;
    DraggingThumbnail := false;
    with Source as TListBox do
      begin
        StartPosition := ItemAtPos(ThumbnailStartPoint, True) ;
        DropPosition := ItemAtPos(DropPoint, True) ;
        writeln(StartPosition, ' --> ', DropPosition);
        Items.Move(StartPosition, DropPosition) ;
        // Now apply move to contents of TOcrivistProject, too
        CurrentProject.MovePage(StartPosition, DropPosition);
        ThumbnailListBox.ItemIndex := DropPosition;
        ThumbnailListBoxClick( ThumbnailListBox );
      end;
 end;

procedure TMainForm.ThumbnailListBoxDragOver ( Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean ) ;
begin
  Accept := Source = ThumbnailListBox;
  TListBox(Sender).ItemIndex := TListBox(Sender).ItemAtPos(Point(X, Y), true);
end;

procedure TMainForm.ThumbnailListBoxMouseDown ( Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer ) ;
begin
  ThumbnailStartPoint.X := X;
  ThumbnailStartPoint.Y := Y;
  DraggingThumbnail := true;
  MultiSelecting := ssCtrl in Shift;
end;

procedure TMainForm.ThumbnailListBoxMouseUp ( Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer ) ;
begin
    DraggingThumbnail := false;
    MultiSelecting := false;
end;

procedure TMainForm.UpdateScannerStatus ( Sender: TObject ) ;
begin
 {$IFDEF HAS_LIBSANE}
 ScanPageMenuItem.Enabled := ScannerHandle<>nil;
 {$ENDIF}
end;

procedure TMainForm.ThumbnailListBoxClick ( Sender: TObject ) ;
var
  X: Integer;
  S: TSelector;
begin
  if AddingThumbnail then exit;
  if MultiSelecting then Exit;
  if ThumbnailListBox.ItemIndex<0 then Exit;
  for X := CurrentProject.CurrentPage.SelectionCount-1 downto 0 do
    ICanvas.DeleteSelector(X);
  CurrentProject.ItemIndex := TListBox(Sender).ItemIndex;
  ICanvas.Picture := CurrentProject.CurrentPage.PageImage;
  Invalidate;
  for x := 0 to CurrentProject.CurrentPage.SelectionCount-1 do
    begin
      ICanvas.AddSelection(CurrentProject.CurrentPage.Selection[x]);
      ICanvas.GetSelector(ICanvas.SelectionCount-1).OnSelect := @SelectionChange;
    end;
  editor.OCRData := CurrentProject.CurrentPage.OCRData;
  if CurrentProject.CurrentPage.OCRData=nil
     then ProcessPageMenuItem.Click;
  CorrectionviewImage.Picture.Clear;
end;

procedure TMainForm.ThumbnailListBoxDrawItem ( Control: TWinControl; Index: Integer;
  ARect: TRect; State: TOwnerDrawState ) ;
var
  LeftOffset: Integer;
begin
  if not assigned(TListbox(Control).Items.Objects[Index]) then exit;
  LeftOffset := (TListbox(Control).ClientWidth-TBitmap(TListbox(Control).Items.Objects[Index]).Width) div 2;
  if LeftOffset<2 then LeftOffset := 2;
  TListbox(Control).Canvas.Rectangle(ARect);
  TListbox(Control).Canvas.Draw(LeftOffset, ARect.Top + TListbox(Control).Canvas.TextHeight('Yy')+2, TBitmap(TListbox(Control).Items.Objects[Index]));
  TListbox(Control).Canvas.TextOut(2, ARect.Top + 2, IntToStr(Index+1) + ': ' + TListbox(Control).Items[Index]);
end;

procedure TMainForm.LoadPageMenuItemClick ( Sender: TObject ) ;
var
  newpage: PLPix;
  pagename: String;
  x, i: Integer;
begin
  OpenDialog.Options := OpenDialog.Options + [ofAllowMultiSelect];
  OpenDialog.Filter := 'Image files|*.tif;*.tiff;*.bmp;*.png;*.jpg|All files|*';
  if OpenDialog.Execute then
     for i := 0 to OpenDialog.Files.Count-1 do
        begin
          newpage := pixRead(PChar(OpenDialog.Files[i]));
          if newpage<>nil then
             begin
               pagename :=  ExtractFileNameOnly(OpenDialog.Files[i]);
               pixSetText(newpage, PChar(pagename));
               LoadPage(newpage, ThumbnailListBox.ItemIndex+1);
               CurrentProject.Pages[ThumbnailListBox.ItemIndex].Imagesource := OpenDialog.FileName;
               if not MainPanel.Visible
                  then ProcessPageMenuItem.Click;
               for x := 0 to MainToolBar.ControlCount-1 do
                  if TControl(MainToolBar.Controls[x]).Tag=1
                     then TControl(MainToolBar.Controls[x]).Visible := true;
             end
           else ShowMessage('Error when loading page ' + OpenDialog.Files[i]);
        end;
end;

procedure TMainForm.OpenProjectMenuItemClick ( Sender: TObject ) ;
var
  x: Integer;
begin
  with OpenDialog do
       begin
         DefaultExt := '.ovp';
         Filter := 'Ocrivist Projects|*.ovp|All Files|*';
         Title := 'Open Ocrivist project';
       end;
  if OpenDialog.Execute then
    begin
      NewProjectMenuItemClick(nil);
      if CurrentProject.LoadfromFile(OpenDialog.FileName)=0 then
        begin
          ICanvas.Scale :=  CurrentProject.ViewerScale;
          ThumbnailListBox.Clear;
          for x := 0 to CurrentProject.PageCount-1 do
             ThumbnailListBox.Items.AddObject( CurrentProject.Pages[x].Title, CurrentProject.Pages[x].Thumbnail );
          ThumbnailListBox.ItemIndex := CurrentProject.ItemIndex;
          ThumbnailListBoxClick(ThumbnailListBox);
          Caption := 'Ocrivist : ' + CurrentProject.Title;
        end;
    end;
end;

procedure TMainForm.SaveAsMenuItemClick ( Sender: TObject ) ;
begin
 with SaveDialog do
      begin
        DefaultExt := '.ovp';
        Filter := 'Ocrivist Projects|*.ovp|All Files|*';
        Title := 'Save project as ..';
        FileName := CurrentProject.Title + '.ovp';
      end;
  if SaveDialog.Execute then
    begin
      ProgressForm.SetMainText( 'Saving project...' );
      ProgressForm.Show(nil);
      Application.ProcessMessages;
      try
      CurrentProject.SaveToFile(SaveDialog.FileName);
      Caption := 'Ocrivist : ' + CurrentProject.Title;
      ThumbnailListBox.ItemIndex := CurrentProject.ItemIndex;
      finally
        ProgressForm.Hide;
      end;
    end;
end;

procedure TMainForm.ScanPageMenuItemClick ( Sender: TObject ) ;
var
  newpage: PLPix;
  temppix: PLPix;
  nametext: String;
  resolution: Integer;
begin
 newpage := nil;
  if not ScanSettingsMenuItem.Enabled
       then SetScannerMenuItemClick(nil);

  if ScanSettingsMenuItem.Enabled then
       try
         Enabled := false;
         ScanCancelled := false;
         ProgressForm.SetMainText('Initialising scanner...');
         ProgressForm.Show(@CancelScan);
         Application.ProcessMessages;
         resolution := ScannerForm.GetResolution;
         Application.ProcessMessages;
         {$IFDEF MSWINDOWS}
         TwainScanner := TTwainScanner.Create;
         {$ENDIF}
         if not ScanCancelled
            then SetScannerOptions;
         Application.ProcessMessages;
         if not ScanCancelled then
           begin
              {$IFDEF MSWINDOWS}
              ProgressForm.Hide;
              newpage := TwainScanner.ScanToPix;
              TwainScanner.Free;
              {$ENDIF}
              {$IFDEF LINUX}
              newpage := ScanToPix(ScannerHandle, @ShowScanProgress);
              ProgressForm.Hide;
              {$ENDIF}
             pixSetResolution(newpage, resolution, resolution);
             nametext := Format('scan_%.3d', [CurrentProject.LoadCount]);
             pixSetText(newpage, PChar( nametext ));
             if newpage<>nil then
                begin
                  if AutoDeskewOnScan then
                     begin
                       ProgressForm.SetMainText('Deskewing page...');
                       ProgressForm.Show(nil);
                       temppix := pixDeskew(newpage, 0);
                       if temppix<>nil then
                         begin
                           pixDestroy(@newpage);
                           newpage := temppix;
                         end;
                     end;
                  LoadPage(newpage, ThumbnailListBox.ItemIndex+1)
                end
             else ShowMessage('Scan page failed');
           end;
       finally
         Enabled := true;
         ProgressForm.Hide;
       end;
end;

procedure TMainForm.SetScannerMenuItemClick ( Sender: TObject ) ;
begin
  {$IFDEF HAS_LIBSANE}
  Enabled := false;
  try
    ScanSettingsMenuItem.Enabled := SelectScanner;
  finally
    Enabled := true;
  end;
  {$ENDIF}
  {$IFDEF WINDOWS}
  ScanSettingsMenuItem.Enabled := SelectDevice>-1;
  if ScanSettingsMenuItem.Enabled then
    begin
      Application.ProcessMessages;
      GetSelectedScannerSettings;
      ScannerForm.ShowModal;
    end;

  {$ENDIF}
end;

procedure TMainForm.TesseractButtonClick ( Sender: TObject ) ;
begin
  if CurrentProject.PageCount<1 then Exit;
  Enabled := false;
  ProgressForm.SetMainText('Reading page...');
  ProgressForm.SetUpdateText(' ');
  ProgressForm.Show(nil);
  try
    OCRPage(ThumbnailListBox.ItemIndex);
    Editor.OCRData := CurrentProject.CurrentPage.OCRData;
    CurrentProject.Language := GetLanguageToken(LanguageComboBox.Text);
    if not OCRPanel.Visible then
       begin
         OCRScreenMenuItem.Click;
         OCRScreenMenuItem.Checked := True;
       end;
  finally
    Enabled := true;
    ProgressForm.Hide;
  end;
end;

procedure TMainForm.ViewMenuItemClick ( Sender: TObject ) ;
begin
  Case TComponent(Sender).Tag of
       0: ICanvas.Mode := vmFitToHeight;   // Fit to Height
       1: ICanvas.Mode := vmFitToWidth;    // Fit to Width
       else
         ICanvas.Scale := TMenuItem(Sender).Tag/100;
       end;
  CurrentProject.ViewerScale := ICanvas.Scale;
end;

procedure TMainForm.CancelScan(Sender: TObject);
begin
  {$IFDEF HAS_LIBSANE}
  Application.ProcessMessages;
  ScanCancelled := true;
  sane_cancel(ScannerHandle);
  {$ENDIF}
end;

procedure TMainForm.CancelDjVu ( Sender: TObject ) ;
begin
  DjvuCancelled := true;
  Application.ProcessMessages;
end;

procedure TMainForm.MakeSelection ( Sender: TObject ) ;
var
  S: TSelector;
begin
  if ICanvas.SelectionMode=smSelect then
    begin
      ICanvas.AddSelection(ICanvas.CurrentSelection);
      ICanvas.GetSelector(ICanvas.SelectionCount-1).OnSelect := @SelectionChange;
      CurrentProject.CurrentPage.AddSelection(ICanvas.CurrentSelection);
    end;
end;

procedure TMainForm.DeleteSelection(Sender: TObject);
begin
  writeln('delete selection');
  if CurrentProject<>nil then
     CurrentProject.CurrentPage.DeleteSelection(ICanvas.SelectionIndex(TSelector(Sender)));
end;

procedure TMainForm.SelectionChange ( Sender: TObject ) ;
var
  SelectionId: LongInt;
begin
  if ICanvas.SelectionMode=smSelect then
    begin
      SelectionId := ICanvas.SelectionIndex(TSelector(Sender));
      ICanvas.SetSelection(SelectionId, TSelector(Sender).Selection);
      CurrentProject.CurrentPage.Selection[SelectionId] := UnScaleRect(TSelector(Sender).Selection, ICanvas.Scale);

    end;
end;

// called by ICanvas when page image is changed
procedure TMainForm.UpdateThumbnail ( Sender: TObject ) ;
var
  thumbBMP: TBitmap;
begin
 if AddingThumbnail then exit
    else if ThumbnailListBox.Count<1 then exit;
 thumbBMP := CurrentProject.CurrentPage.Thumbnail;
 if thumbBMP<>nil then
   begin
     ThumbnailListBox.Items.Objects[ThumbnailListBox.ItemIndex] := thumbBMP;
     ThumbnailListBox.Invalidate;
   end;
end;

procedure TMainForm.ShowScanProgress ( progress: Single ) ;
var
  percentcomplete: Integer;
begin
  percentcomplete := Trunc(progress*100);
  ProgressForm.SetMainText('Scanning: ' + IntToStr(percentcomplete) + '%');
  Application.ProcessMessages;
end;

procedure TMainForm.ShowOCRProgress ( progress: Single ) ;
begin
  Inc(OCRProgressCount);
  ProgressForm.SetUpdateText('Processing line ' + IntToStr(OCRProgressCount));
  Application.ProcessMessages;
end;

procedure TMainForm.ShowSaveProgress ( Sender: TObject; const Pct: Double ) ;
begin
  ProgressForm.SetProgressBar(Trunc(Pct));
end;

procedure TMainForm.LoadPage ( newpage: PLPix; pageindex: integer ) ;
var
  X: Integer;
  thumbBMP: TBitmap;
begin
 AddingThumbnail := true;  //avoid triggering reload through ThumbList.Click;
 ICanvas.Picture := newpage;
 Application.ProcessMessages;  // Draw the screen before doing some background work
 If CurrentProject.ItemIndex>=0
  then for X := CurrentProject.CurrentPage.SelectionCount-1 downto 0 do
       ICanvas.DeleteSelector(X);
 Editor.OCRData := nil;
 CurrentProject.AddPage(ICanvas.Picture, pageindex);
 thumbBMP := CurrentProject.CurrentPage.Thumbnail;
 if thumbBMP<>nil then
   begin
     ThumbnailListBox.Items.InsertObject(pageindex, newpage^.text, thumbBMP);
   end;
 ThumbnailListBox.ItemIndex := pageindex;
 if ThumbnailListBox.Count>1
  then pagecountLabel.Caption := Format('%d pages', [ThumbnailListBox.Count])
  else pagecountLabel.Caption := #32;  // if label is empty it changes its height
 AddingThumbnail := false;
 DelPageButton.Enabled := ThumbnailListBox.Count>0;
end;

procedure TMainForm.DoCrop;
var
  newpix: PLPix;
  oldpix: PLPix;
begin
 if CurrentProject.CurrentPage=nil then exit;
 newpix := nil;
 oldpix := ICanvas.Picture;
 newpix := CropPix( oldpix,  ICanvas.CurrentSelection );
 if newpix <> nil then
   begin
     ICanvas.ClearSelection;
     ICanvas.Picture := newpix;
     CurrentProject.CurrentPage.PageImage := newpix;
     if oldpix <> nil
        then pixDestroy(@oldpix);
   end;
end;

function TMainForm.AnalysePage ( pageindex: integer ) : integer;
var
  Pix: PLPix;
  BinaryPix: PLPix;
  TextMask: PLPix;
  B: PBoxArray;
  x, y, w, h: Integer;
  count: Integer;
  p: PLPix;
begin
  Result := 0;
  if (pageindex<0) or (pageindex>CurrentProject.PageCount-1) then Exit;
  Textmask := nil;
  BinaryPix := nil;
  Pix := CurrentProject.Pages[pageindex].PageImage;
  if pixGetDepth(Pix) > 1
     then BinaryPix := pixThresholdToBinary(Pix, 60)
     else BinaryPix := pixClone(Pix);
  if pixGetRegionsBinary(BinaryPix, nil, nil, @TextMask, 0) = 0 then
     begin
       B := pixConnComp(TextMask, nil, 8);
       try
       boxaWrite('/tmp/boxes.txt', B);
       for count := 0 to boxaGetCount(B)-1 do
            begin
              boxaGetBoxGeometry(B, count, @x, @y, @w, @h);
              CurrentProject.Pages[pageindex].AddSelection( Rect(x-10, y-5, x+w+10, y+h+5) );
//              ICanvas.AddSelection(Rect(x-10, y-5, x+w+10, y+h+5));
            end;
       Result := boxaGetCount(B);
       finally
         if B<>nil then
            boxaDestroy(@B);
         if Textmask <> nil then
            pixDestroy(@TextMask);
       end;
     end;
  if BinaryPix<>nil then
       pixDestroy(@BinaryPix);
end;

procedure TMainForm.OCRPage ( pageindex: integer ) ;
var
  OCRJob: TTesseractPage;
  x: Integer;
begin
  if (pageindex<0) or (pageindex>CurrentProject.PageCount-1) then Exit;
  try
    OCRJob := TTesseractPage.Create(CurrentProject.Pages[pageindex].PageImage, PChar(OCRDatapath), PChar(OCRLanguage));
    OCRProgressCount := 0;
    OCRJob.OnOCRLine := @ShowOCRProgress;
    for x := 0 to CurrentProject.Pages[pageindex].SelectionCount-1 do
        OCRJob.RecognizeRect( CurrentProject.Pages[pageindex].Selection[x] );
    CurrentProject.Pages[pageindex].OCRData := OCRJob;
    CurrentProject.Language := GetLanguageToken(LanguageComboBox.Text);
    OCRPanel.Visible := true;
    StatusBar.Panels[1].Text := '';
  except
    {$IFDEF DEBUG}
    writeln('Error in OCRPage');
    {$ENDIF}
  end;
end;

procedure TMainForm.DoSpellcheck;
begin
  Editor.Spellcheck;
end;

procedure TMainForm.EditorSelectToken ( aline, aword: integer ) ;
var
  topline: Integer;
  selTop: LongInt;
  selBottom: Integer;
  selBox: PLBox;
  tmpPix: PLPix;
  pixd: PLPix;
  wtop: Integer;
  wleft: Integer;
  wwidth: Integer;
  wheight: Integer;
  pixwidth : Integer;
begin
  if aline>0 then
    begin
      topline := aline-1;
      selTop := Editor.OCRData.Lines[topline].Box.Top;
    end
  else
    begin
      topline := aline;
      selTop := Editor.OCRData.Lines[aline].Box.Top;
    end;
  if aline<Editor.OCRData.Linecount-1
   then selBottom := Editor.OCRData.Lines[topline+2].Box.Bottom-selTop
   else selBottom := Editor.OCRData.Lines[aline].Box.Bottom-selTop;
  selBox := boxCreate(Editor.OCRData.Lines[aline].Box.Left,
            selTop,
            Editor.OCRData.Lines[aline].Box.Right - Editor.OCRData.Lines[aline].Box.Left,
            selBottom);
  tmpPix := pixClipRectangle(CurrentProject.CurrentPage.PageImage, selBox, nil);
  pixd := pixConvertTo32(tmpPix);
  boxDestroy(@selBox);
  wtop :=  Editor.OCRData.Lines[aline].Words[aword].Box.Top - selTop;
  wleft := Editor.OCRData.Lines[aline].Words[aword].Box.Left - Editor.OCRData.Lines[aline].Box.Left;
  wwidth := Editor.OCRData.Lines[aline].Words[aword].Box.Right - Editor.OCRData.Lines[aline].Words[aword].Box.Left;
  wheight := Editor.OCRData.Lines[aline].Words[aword].Box.Bottom - Editor.OCRData.Lines[aline].Words[aword].Box.Top;
  selBox := boxCreate(wleft-5, wtop-5, wwidth+10, wheight+10);
  pixRenderBoxBlend(pixd, selBox, 4, 255, 150, 0, 0.8);
  pixGetDimensions(pixd, @pixwidth, nil, nil);
  ScaleToBitmap(pixd, CorrectionviewImage.Picture.Bitmap, CorrectionPanel.Width/pixwidth) ;
  boxDestroy(@selBox);
  pixDestroy(@tmpPix);
  pixDestroy(@pixd);
end;

function TMainForm.PopulateLanguageList: Integer;
Var
   SearchResult : TSearchRec;
   Filemask: String;
   token: String;
begin
  Result := 0;
  LanguageComboBox.Items.Clear;
  Filemask := OCRDatapath + '*.traineddata';
  writeln (Filemask);
  If FindFirst (Filemask, (faAnyFile And Not faDirectory) , SearchResult) = 0 Then
     try
       token := ExtractFileNameWithoutExt(SearchResult.Name);
       LanguageComboBox.Items.Add(GetLanguageFromToken(token));
       While FindNext (SearchResult) = 0 Do
             Begin
             token := ExtractFileNameWithoutExt(SearchResult.Name);
             LanguageComboBox.Items.Add(GetLanguageFromToken(token));
             End;
     finally
       FindClose (SearchResult);
     end;
  Result := LanguageComboBox.Items.Count;
end;



end.

