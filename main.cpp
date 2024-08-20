#include <wx/wx.h>

// Define a new application type
class MyApp : public wxApp {
public:
  virtual bool OnInit();
};

// Define a new frame type
class MyFrame : public wxFrame {
public:
  MyFrame(const wxString& title);

  void OnQuit(wxCommandEvent& event);
  void OnAbout(wxCommandEvent& event);

private:
  wxDECLARE_EVENT_TABLE();
};

// Event table for MyFrame
wxBEGIN_EVENT_TABLE(MyFrame, wxFrame)
    EVT_MENU(wxID_EXIT, MyFrame::OnQuit)
    EVT_MENU(wxID_ABOUT, MyFrame::OnAbout)
wxEND_EVENT_TABLE()

// Implement MyApp::OnInit
bool MyApp::OnInit() {
  MyFrame* frame = new MyFrame("Hello wxWidgets");
  frame->Show(true);
  return true;
}

// Implement MyFrame constructor
MyFrame::MyFrame(const wxString& title)
    : wxFrame(NULL, wxID_ANY, title) {
  wxMenu* menuFile = new wxMenu;
  menuFile->Append(wxID_EXIT);

  wxMenu* menuHelp = new wxMenu;
  menuHelp->Append(wxID_ABOUT);

  wxMenuBar* menuBar = new wxMenuBar;
  menuBar->Append(menuFile, "&File");
  menuBar->Append(menuHelp, "&Help");

  SetMenuBar(menuBar);
  CreateStatusBar();
  SetStatusText("Welcome to wxWidgets!");
}

// Implement event handlers
void MyFrame::OnQuit(wxCommandEvent& WXUNUSED(event)) {
  Close(true);
}

void MyFrame::OnAbout(wxCommandEvent& WXUNUSED(event)) {
  wxMessageBox("This is a wxWidgets Hello World example",
               "About Hello wxWidgets", wxOK | wxICON_INFORMATION);
}

// Implement the main function
wxIMPLEMENT_APP(MyApp);