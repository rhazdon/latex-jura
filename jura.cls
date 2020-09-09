%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% General
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{jura}

\RequirePackage{ifthen}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Options
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\DeclareOption{american}{
    \PassOptionsToPackage{american,ngerman}{babel}
    \AtBeginDocument{\ClassInfo{jura}{Die Sprache Englisch (Amerikanisch) wurde zusätzlich aktiviert.}}
}
\DeclareOption{british}{
    \PassOptionsToPackage{british,ngerman}{babel}
    \AtBeginDocument{\ClassInfo{jura}{Die Sprache Englisch (Britisch) wurde zusätzlich aktiviert}}
}
\DeclareOption{english}{
    \PassOptionsToPackage{british,ngerman}{babel}
    \AtBeginDocument{\ClassInfo{jura}{Die Sprache Englisch (Britisch) wurde zusätzlich aktiviert}}
}

\DeclareOption{latin1}{\PassOptionsToPackage{latin1}{inputenc}}
\DeclareOption{utf8}{\PassOptionsToPackage{utf8}{inputenc}}
\DeclareOption{ansinew}{\PassOptionsToPackage{ansinew}{inputenc}}
\DeclareOption{applemac}{\PassOptionsToPackage{applemac}{inputenc}}

% Centers the page numbers.
\newif\if@centerpagenumber
\@centerpagenumberfalse
\DeclareOption{centerpagenumber}{
  \AtBeginDocument{\@classiclayoutfalse}
}

% Displays the short author name and the matrikel number upper left on every page.
\newif\if@headline
\@headlinefalse
\DeclareOption{headline}{\@headlinetrue}

% Displays the headline on the title page on the left site.
\newif\if@headlinetitlepageleft
\@headlinetitlepageleftfalse
\DeclareOption{headlinetitlepageleft}{\@headlinetitlepagelefttrue}

% TODO: Kommentieren
\newif\if@automatter
\DeclareOption{noautomatter}{\@automatterfalse}
\DeclareOption{automatter}{\@automattertrue}

% TODO: Kommentieren
\newif\if@fontbp
\DeclareOption{10bp}{\@fontbptrue\PassOptionsToClass{10pt}{jurabook}}
\DeclareOption{11bp}{\@fontbptrue\PassOptionsToClass{11pt}{jurabook}}
\DeclareOption{12bp}{\@fontbptrue\PassOptionsToClass{12pt}{jurabook}}
\DeclareOption{10pt}{\@fontbpfalse\PassOptionsToClass{10pt}{jurabook}}
\DeclareOption{11pt}{\@fontbpfalse\PassOptionsToClass{11pt}{jurabook}}
\DeclareOption{12pt}{\@fontbpfalse\PassOptionsToClass{12pt}{jurabook}}
\ExecuteOptions{12bp,american,utf8,automatter}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{jurabook}}
\ProcessOptions\relax
\RequirePackage{iftex}
\LoadClass[a4paper,oneside,showpagenumber,classiclayout]{jurabook}

% TODO: Kommentieren
\if@fontbp
   \def\@vpt{5bp}
   \def\@vipt{6bp}
   \def\@viipt{7bp}
   \def\@viiipt{8bp}
   \def\@ixpt{9bp}
   \def\@xpt{10bp}
   \def\@xipt{10.95bp}
   \def\@xiipt{12bp}
   \def\@xivpt{14.4bp}
   \def\@xviipt{17.28bp}
   \def\@xxpt{20.74bp}
   \def\@xxvpt{24.88bp}
   \normalsize
\fi

% TODO: Kommentieren
\ifPDFTeX
  \RequirePackage{inputenc}
  \RequirePackage[T1]{fontenc}
  \usepackage{tgtermes}
  \usepackage[matchlowercase]{tgheros}
  \usepackage[matchlowercase]{tgcursor}
  \RequirePackage{textcomp}
  \RequirePackage{eurosym}
  \let\texteuro\euro
  \DeclareUnicodeCharacter{20AC}{\unspace\,\euro}
\else
  \RequirePackage{fontspec}
  \setmainfont{Times New Roman}
\fi

\RequirePackage{babel}
\RequirePackage{indentfirst}
\RequirePackage{geometry}

\if@headline
   \geometry{left=7cm,right=1cm,top=1cm,bottom=1.5cm,footskip=0.5cm,marginparwidth=5cm,verbose,includehead}
\else
   \geometry{left=7cm,right=1cm,top=1cm,bottom=1.5cm,footskip=0.5cm,marginparwidth=5cm,verbose}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Document
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\savegeometry{pagemainmatter}
\newgeometry{left=2cm,right=2cm,top=2cm,bottom=2cm}
\savegeometry{pagefrontmatter}
\RequirePackage{ellipsis}
\RequirePackage[autostyle]{csquotes}
\defineshorthand{"`}{\openautoquote}
\defineshorthand{"'}{\closeautoquote}
\RequirePackage[final,tracking=smallcaps,expansion=alltext,protrusion=true]{microtype}
\SetTracking{encoding=*,shape=sc}{50}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Package: jurabib
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{jurabib}% Bibliografie
\jbedseplikecite% Die Separation der Herausgeber im Literaturverzeichnis entspricht der im Zitat
\renewcommand*{\bibatsep}{,}% Komma nach dem Titel des Buches oder des Artikels
\renewcommand*{\jbaensep}{,}% Komma nach der Auflage, vor dem Jahr
\renewcommand*{\bibbdsep}{}% kein Komma nach Ort und vor dem Jahr
\renewcommand*{\bibjtsep}{}% Komma vor dem Namen der Zeitschrift
\renewcommand*{\bibbtsep}{in:~}% für in collection, Komma vor dem Titel
\renewcommand*{\ajtsep}{}% Abstand nach dem Namen der Zeitschrift
\renewcommand*{\artnumberformat}{\unskip,\space H.~}% bei den Zeitschriften statt Nr. H.

\jurabibsetup{
  annotatorfirstsep=in,
  bibformat=tabular,
  titleformat={all,commasep},% Komma vor dem Titel
  commabeforerest,% Komma vor der Seitenangabe in der Fußnote
  superscriptedition=all,% Ausgabe oben
  howcited=all,
  authorformat=dynamic
}

\bibliographystyle{jurabib}
\bibtotoc

\renewcommand*{\bibleftcolumn}{\textwidth/3}
\renewcommand*{\bibrightcolumn}{\textwidth-\bibleftcolumn-0.5cm}

\usepackage[ngerman]{varioref}
\vref@addto\extrasngerman{
  \def\reftextafter {auf S.~\thevpagerefnum}
  \def\reftextbefore{auf S.~\thevpagerefnum}
}

\renewcommand{\xref}[1]{
  % Vereinfacht Zitation
  \ref{#1} \vpageref{#1}
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Headline
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This headline would be displayd on every page, if headline is set.
\if@headline
   \renewcommand{\SetJuboPagestyle}{
      \pagestyle{fancy}
      \fancyhf{}
      \lhead{\@shortauthor{} -- \@matrikelnummer}
      \if@centerpagenumber
         \cfoot{\thepage}
      \else
         \rfoot{\thepage}
      \fi
      \renewcommand{\headrulewidth}{0pt}
   }
\else
   \renewcommand{\headrulewidth}{0pt}
   \fancypagestyle{plain}{
      \fancyhead{}
      \if@centerpagenumber\else
         \fancyhf{}
         \fancyfootoffset[RO]{2cm}
         \rfoot{\thepage}
      \fi}
   \AtBeginDocument{
      \fancyhead{}}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Chapter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Kapitel anpassen
\renewcommand{\jb@chapter@style}{\LARGE\bfseries}
\setlength{\jb@chapterafter@length}{20\p@}
\setlength{\jb@chapterbefore@length}{15\p@}
\newcommand{\setspacebeforechapter}[1]{\setjbooklength{chapterbefore}{#1}}
\newcommand{\setspaceafterchapter}[1]{\setjbooklength{chapterafter}{#1}}

%%% Abschnitte anpassen
\newlength{\sectionbefore}
\setlength{\sectionbefore}{2ex}
\newlength{\sectionafter}
\setlength{\sectionafter}{1ex}
\newcommand{\setspacebeforesection}[1]{\setlength{\sectionbefore}{#1}}
\newcommand{\setspaceaftersection}[1]{\setlength{\sectionafter}{#1}}
\renewcommand\section{
  \@startsection
    {section}
    {1}
    {\z@}
    {-1\sectionbefore}
    {\sectionafter}
    {\normalfont\Large\bfseries}
}
\renewcommand\subsection{
  \@startsection
    {subsection}
    {2}
    {\z@}
    {-1\sectionbefore}
    {\sectionafter}
    {\normalfont\large\bfseries}
}
\renewcommand{\subsubsection}{
  \@startsection
    {subsubsection}
    {3}
    {\z@}
    {-1\sectionbefore}
    {\sectionafter}
    {\normalfont\normalsize\bfseries}}
\renewcommand{\subthreesection}{
  \@startsection
    {subthreesection}
    {4}
    {\z@}
    {-1\sectionbefore}
    {\sectionafter}
    {\normalfont\normalsize\bfseries}
}
\renewcommand*{\subfoursection}{
  \@startsection
    {subfoursection}
    {5}
    {\z@}
    {-1\sectionbefore}
    {\sectionafter}
    {\normalfont\normalsize\bfseries}
}
\renewcommand*{\subfivesection}{
  \@startsection
    {subfivesection}
    {6}
    {\z@}
    {-1\sectionbefore}
    {\sectionafter}
    {\normalfont\normalsize\bfseries}
}
\renewcommand*{\subsixsection}{
  \@startsection
    {subsixsection}
    {7}
    {\z@}
    {-1\sectionbefore}
    {\sectionafter}
    {\normalfont\normalsize\bfseries}
}
\renewcommand*{\subsevensection}{
  \@startsection
    {subsevensection}
    {8}
    {\z@}
    {-1\sectionbefore}
    {\sectionafter}
    {\normalfont\normalsize\bfseries}
}
\renewcommand*{\subeightsection}{
  \@startsection
    {subeightsection}
    {9}
    {\z@}
    {-1\sectionbefore}
    {\sectionafter}
    {\normalfont\normalsize\bfseries}
}

% Rename the subsections because noone needs subsubsubsubsub...
\let\subsubsubsection\subthreesection
\let\subsubsubsubsection\subfoursection
\let\subsubsubsubsubsection\subfivesection
\let\subsubsubsubsubsubsection\subsixsection
\let\subsubsubsubsubsubsubsection\subsevensection
\let\subsubsubsubsubsubsubsubsection\subeightsection

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Frontmatter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\let\@ORIGfrontmatter\frontmatter
\renewcommand\frontmatter{
  \@ORIGfrontmatter
  \loadgeometry{pagefrontmatter}
  \onehalfspacing% Muss nochmal gesetzt werden, da es sonst durch loadgeometry verloren geht
  \reversemarginpar% Muss nochmal gesetzt werden, da es sonst durch loadgeometry verloren geht
    \fancyfootoffset[RO]{0cm}
    \pagestyle{fancyplain}
    \if@headline
      \fancyheadoffset[L]{0pt}
    \fi
}

\if@automatter
   \AtBeginDocument{\frontmatter}
\fi

\let\@ORIGmainmatter\mainmatter
\renewcommand\mainmatter{
  \@ORIGmainmatter
  \loadgeometry{pagemainmatter}
  \onehalfspacing
  \reversemarginpar

  \fancyfootoffset[RO,RE]{0cm}
  \if@headline
    \fancyheadoffset[L]{\marginparsep+\marginparwidth}
  \fi
}

\renewcommand{\chapter}{
  \if@automatter
  % Automatisch auf Hauptteil umschalten
     \ifnum\value{chapter}=0\mainmatter\fi
  \fi
  \chapterlevel
  \if@headline\else\jubo@thispagestyle@empty\fi
  \global\@topnum\z@
  \@afterindentfalse
  \secdef\@chapter\@schapter
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% TODO: Comment
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\setpg}[2][]{\setpgfront{#1}\setpgmain{#2}}
\newcommand{\setpgmain}[1]{\newgeometry{#1}\savegeometry{pagemainmatter}}
\newcommand{\setpgfront}[1]{\newgeometry{#1}\savegeometry{pagefrontmatter}}

%%% Kein § vor der Kapitelnummer; korrekte Abstände
\renewcommand{\make@jubo@chaptercomplete}{
  \renewcommand{\jubo@chaptercomplete}{\thechapter\chapterextra}
}

%%% Eintrag der Kapitel ohne Nummer im TOC auch fett
\renewcommand{\jb@tocextras@style}{\normalfont\bfseries}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Title page
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Autor in Normalgröße
\renewcommand*{\jb@author@style}{\normalsize}

%%% Voreinstellung für Titelseite
\def\@title{Hausarbeit}
\def\@shortauthor{\@empty}
\let\@@@author\author
\def\author{\@ifnextchar[{\@@author}{\@@@author}}
\def\@@author[#1]#2{\gdef\@shortauthor{#1}\@@@author{#2}}

%%% Neue Befehle für die Titelseite
\def\@semester{}
\def\@fachsemester{}
\def\semester{\@ifnextchar[{\@@semester}{\@@@semester}}
\def\@@semester[#1]#2{\gdef\@fachsemester{#1}\gdef\@semester{#2}}
\def\@@@semester#1{\gdef\@semester{#1}}
\def\@prof{}
\def\prof#1{\gdef\@prof{#1}}
\def\@matrikelnummer{}
\def\matrikelnummer#1{\gdef\@matrikelnummer{#1}}

\renewcommand{\maketitle}{
  \begin{titlepage}
    \let\footnotesize\small
    \let\footnoterule\relax
    \let\footnote\thanks
    {\jb@author@style
       \if@headlinetitlepageleft\else\hfill\fi
       \begin{tabular}[t]{l}
         \@author
         \ifx\@matrikelnummer\@empty\else\tabularnewline Matrikelnummer: \@matrikelnummer\fi
         \ifx\@fachsemester\@empty\else\tabularnewline\@fachsemester\fi
       \end{tabular}\par
      }
    \null\vfil
    %\vskip 60\p@
    \begin{center}
      {\jb@title@style\vskip 2ex \@title\par}
      \ifx\@subtitle\@empty\else{\jb@subtitle@style\vskip 4ex\@subtitle \par}\fi
      \vskip 1ex
      {\ifx\@prof\@empty\else\jb@subtitle@style Bei\ \@prof \par\fi}
       \vskip 2ex
      {\jb@subtitle@style \@semester}
      \vskip 4ex
      {\jb@titledate@style\@date\par}
    \end{center}\par
    \vfil\null
    \@emptytitles
  \end{titlepage}

  % Setze die Seitzählung korrekt
  \setcounter{page}{1}
}

\renewcommand{\@emptytitles}{
  \setcounter{footnote}{0}
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
  \global\let\@subtitle\@empty
  \global\let\@publishinfo\@empty
  \global\let\@birthplace\@empty
  \global\let\@publishplace\@empty
  \global\let\@publishyear\@empty
  \global\let\@firstexaminer\@empty
  \global\let\@secondexaminer\@empty
  \global\let\@examdate\@empty
  \global\let\subtitle\relax
  \global\let\publishinfo\relax
  \global\let\birthplace\relax
  \global\let\publishplace\relax
  \global\let\publishyear\relax
  \global\let\firstexaminer\relax
  \global\let\secondexaminer\relax
  \global\let\examdate\relax
  \global\let\@semester\@empty
  \global\let\@prof\@empty
  \global\let\semester\relax
  \global\let\prof\relax
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% TOC
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Anpassung der Zähler
\renewcommand\thechapter{\Alph{chapter})}
\renewcommand\thesection{\Roman{section}.}
\renewcommand\thesubsection{\arabic{subsection}.}
\renewcommand\thesubsubsection{\alph{subsubsection})}
\renewcommand\thesubfoursection{(\arabic{subfoursection})}
\renewcommand\thesubfivesection{(\alph{subfivesection})}
\renewcommand\thesubsixsection{(\alph{subsixsection}\alph{subsixsection})}
\renewcommand\thesubsevensection{(\alph{subsevensection}\alph{subsevensection}\alph{subsevensection})}
\renewcommand\thesubeightsection{(\roman{subeightsection})}
\renewcommand{\jubo@settocindents}{
  \settowidth{\chapternumwidth}{\chaptername~999\chapterextra\space}% Warum drei x 9? Weil zwei x 9 zu knapp ist.
  \settowidth{\sectionnumwidth}{III.\ }
  \settowidth{\subsectionnumwidth}{8.\ }
  \settowidth{\subsubsectionnumwidth}{b)\ }
  \settowidth{\subthreesectionnumwidth}{bb)\ }
  \settowidth{\subfoursectionnumwidth}{(8)\ }
  \settowidth{\subfivesectionnumwidth}{(b)\ }
  \settowidth{\subsixsectionnumwidth}{(bb)\ }
  \settowidth{\subsevensectionnumwidth}{(bbb)\ }
  \settowidth{\subeightsectionnumwidth}{(iii)\ }
  \setlength{\sectiontocindent}{\chapternumwidth}
  \setlength{\sectiontocindent}{\jb@defaulttocindent@length}% = 1.5em per default
  \setlength{\subsectiontocindent}{\sectiontocindent}
  \addtolength{\subsectiontocindent}{\sectionnumwidth}
  \setlength{\subsubsectiontocindent}{\subsectiontocindent}
  \addtolength{\subsubsectiontocindent}{\subsectionnumwidth}
  \setlength{\subthreesectiontocindent}{\subsubsectiontocindent}
  \addtolength{\subthreesectiontocindent}{\subsubsectionnumwidth}
  \setlength{\subfoursectiontocindent}{\subthreesectiontocindent}
  \addtolength{\subfoursectiontocindent}{\subthreesectionnumwidth}
  \setlength{\subfivesectiontocindent}{\subfoursectiontocindent}
  \addtolength{\subfivesectiontocindent}{\subfoursectionnumwidth}
  \setlength{\subsixsectiontocindent}{\subfivesectiontocindent}
  \addtolength{\subsixsectiontocindent}{\subfivesectionnumwidth}
  \setlength{\subsevensectiontocindent}{\subsixsectiontocindent}
  \addtolength{\subsevensectiontocindent}{\subsixsectionnumwidth}
  \setlength{\subeightsectiontocindent}{\subsevensectiontocindent}
  \addtolength{\subeightsectiontocindent}{\subsevensectionnumwidth}
  \setlength{\paragraphtocindent}{\subeightsectiontocindent}
  \addtolength{\paragraphtocindent}{\subeightsectionnumwidth}
  \setlength{\subparagraphtocindent}{\paragraphtocindent}
  \addtolength{\subparagraphtocindent}{\jb@defaulttocindent@length}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% TODO: Unsorted
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\@setsize#1#2#3#4{
  % Modified 1993.04.07--GDG per KPC
  \@nomath#1
  \let\@currsize#1
  \baselineskip #2
  \baselineskip \baselinestretch\baselineskip
  \parskip \baselinestretch\parskip
  \setbox\strutbox \hbox{
    \vrule height.6\baselineskip
           depth.3\baselineskip
           width\z@}
  \skip\footins \baselinestretch\skip\footins
  \normalbaselineskip\baselineskip#3#4}
\let\@ORIGgeometry\geometry
\renewcommand\geometry[1]{\@ORIGgeometry{#1}
    \setlength{\marginparwidth}{.6\oddsidemargin}
    \addtolength{\marginparwidth}{1in}}
\let\frqq\glqq
\let\flqq\grqq
\tolerance 1414
\hbadness 1414
\emergencystretch 1.5em
\hfuzz 0.3pt
\clubpenalty=5000
\widowpenalty=9999
\vfuzz \hfuzz
\raggedbottom
