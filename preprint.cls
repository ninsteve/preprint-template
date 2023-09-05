%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEMPLATE CLASS FILE.                                                         %
% Written by Steffen W. R. Werner (version 4.1), 04-09-2023                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{preprint}[2023/09/04 S. W. R. Werner Preprint Class (v4.1)]

\newif\iftwocolumn\twocolumnfalse
\DeclareOption{twocolumn}{\twocolumntrue}

\newif\ifhidelinks\hidelinksfalse
\DeclareOption{hidelinks}{\hidelinkstrue}

\newif\ifcolorlinks\colorlinksfalse
\DeclareOption{colorlinks}{\colorlinkstrue}

\newif\ifmonolinks\monolinksfalse
\DeclareOption{monolinks}{\monolinkstrue}

\newif\iflinenumbers\linenumbersfalse
\DeclareOption{linenumbers}{\linenumberstrue}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\ProcessOptions\relax
\iftwocolumn
  \LoadClass[10pt, oneside]{scrartcl}
\else
  \LoadClass[11pt, oneside]{scrartcl}
\fi


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% META INFORMATION.                                                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Hide current dates.
\date{}

% Author part.
\RequirePackage[noblocks]{authblk}

\renewcommand\Affilfont{\itshape\small}

\newlength{\authorsep}
\setlength\authorsep{2\baselineskip}
\renewcommand\Authsep{\hspace*{\authorsep}}
\renewcommand\Authand{\hspace*{\authorsep}}
\renewcommand\Authands{\hspace*{\authorsep}}

% Email and ORCID.
\newcommand{\email}[1]{{\normalfont Email:~\texttt{\href{mailto:#1}{#1}}}}
\newcommand{\orcid}[1]{{\normalfont ORCID:~\texttt{\href{https://orcid.org/#1}{#1}}}}


% Header and footer infos.
\RequirePackage{scrlayer-scrpage}
\RequirePackage{scrdate}

\let\@shorttitle\empty
\newcommand{\shorttitle}[1]{\gdef\@shorttitle{#1}}

\let\@shortauthor\empty
\newcommand{\shortauthor}[1]{\gdef\@shortauthor{#1}}

\let\@shortinstitute\empty
\newcommand{\shortinstitute}[1]{\gdef\@shortinstitute{#1}}

\ohead{\usekomafont{pagenumber}\thepage}

% Footline.
\let\@shortdate\empty%
\newcommand{\shortdate}[1]{\gdef\@shortdate{#1}}

  
% Abstract parts.
\let\@keywords\empty%
\newcommand{\keywords}[1]{\gdef\@keywords{#1}}

\let\@msc\empty%
\newcommand{\msc}[1]{\gdef\@msc{#1}}

% Maketitle.
\let\oldmaketitle\maketitle
\let\oldabstract\abstract%
\let\endoldabstract\endabstract%

\let\@abstract\empty%
\renewcommand{\abstract}[1]{\gdef\@abstract{#1}}
\newcommand{\novelty}[1]{\gdef\@novelty{#1}}
\newlength{\noveltyboxwidth}

\renewcommand{\maketitle}{%
  % Initial PDF information.
  \hypersetup{%
    pdftitle    = {\@title},%
    pdfauthor   = {\@shortauthor},%
    pdfsubject  = {\@shorttitle},%
    pdfkeywords = {\@keywords},%
    pdfcreator  = {pdfLaTeX with Hyperref},%
    pdfproducer = {LaTeX, hyperref}
  }
  
  % Headers and footers.
  \ifx\@shortauthor\empty%
    \ifx\@shorttitle\empty%
    \else
      \ihead{\@shorttitle}
    \fi
  \else
    \ifx\@shorttitle\empty%
      \ihead{\@shortauthor}
    \else
      \ihead{\@shortauthor:~\@shorttitle}
    \fi
  \fi
  
  \renewcommand*\pagemark{}
  \ifx\@shortinstitute\empty%
    \ifoot*{\small Preprint.}
  \else
    \ifoot*{\small Preprint (\@shortinstitute).}
  \fi
  
  \KOMAoptions{headsepline = true, footsepline = true, plainfootsepline = true}
  \ModifyLayer[addvoffset=-.6ex]{scrheadings.foot.above.line}
  \ModifyLayer[addvoffset=-.6ex]{plain.scrheadings.foot.above.line}
  
  % Footline date.
  \ifx\@shortdate\empty%
    \ofoot*{\small \ISOToday}
  \else
    \ofoot*{\small \@shortdate}
  \fi
  
  % Abstract and plotting.
  \if@twocolumn%
    \makeatletter
    \twocolumn[%
      \begin{@twocolumnfalse}%
        \oldmaketitle%
        \vspace{-2.5\baselineskip}
        \begin{oldabstract}
          \begin{linenumbers}
          \noindent\textbf{Abstract:}
          \@abstract%

          \ifx\@keywords\empty%
            \ifx\@msc\empty%
            \else
              \vspace{1em}
            \fi
          \else
            \vspace{1em}
            \noindent\textbf{Keywords:}
            \@keywords%
          \fi
          
          \ifx\@msc\empty%
          \else
            \vspace{1em}
            \noindent\textbf{Mathematics subject classification:}
            \@msc%
          \fi

          \ifx\@novelty\empty%
          \else
            \setlength{\noveltyboxwidth}{\linewidth}%
            \addtolength{\noveltyboxwidth}{-2.1\fboxsep}%
            \vspace{1em}%
            \noindent\fcolorbox{black!10}{black!10}{%
              \parbox{\noveltyboxwidth}{\textbf{Novelty statement:}
                \@novelty%
              }%
            }%
          \fi
              
          \end{linenumbers}
        \end{oldabstract}
        \vspace{2\baselineskip}
      \end{@twocolumnfalse}]{}
    \makeatother
    \iflinenumbers%
      \linenumbers%
    \fi%
  \else%
    \oldmaketitle%
    \vspace{-2.5\baselineskip}
  
    \begin{oldabstract}
      \noindent\textbf{Abstract:}
      \@abstract
         
      \ifx\@keywords\empty
        \ifx\@msc\empty
        \else
          \vspace{1em}
        \fi
      \else
        \vspace{1em}
        \noindent\textbf{Keywords:}
        \@keywords
      \fi
          
      \ifx\@msc\empty
      \else
        \vspace{1em}
        \noindent\textbf{Mathematics subject classification:}
        \@msc
      \fi
      
      \ifx\@novelty\empty%
      \else
        \setlength{\noveltyboxwidth}{\linewidth}%
        \addtolength{\noveltyboxwidth}{-2.3\fboxsep}%
        \vspace{1em}%
        \noindent\fcolorbox{black!10}{black!10}{%
          \parbox{\noveltyboxwidth}{\textbf{Novelty statement:}
            \@novelty%
          }%
        }%
      \fi
    \end{oldabstract}
    \vspace{0\baselineskip}
    \iflinenumbers
      \linenumbers
      \leftlinenumbers*
    \fi
  \fi%
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PREPRINT STYLE.                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Geometry of page.
\RequirePackage{geometry}
\if@twocolumn
  \geometry{left = 1.5cm, right = 1.5cm, top = 3.0cm, bottom = 3.0cm}
  \setlength{\columnsep}{1.25\baselineskip}
\else
  \geometry{left = 3.0cm, right = 3.0cm, top = 3.0cm, bottom = 3.0cm}
\fi

% References.
\RequirePackage[noadjust]{cite}

% Math packages.
\usepackage{amsmath}

% Line numbers.
\RequirePackage[switch]{lineno}

\newcommand*\patchMATHlinenumbers[1]{%
  \expandafter\let\csname old#1\expandafter\endcsname\csname #1\endcsname
  \expandafter\let\csname oldend#1\expandafter\endcsname\csname end#1\endcsname
  \renewenvironment{#1}%
  {\linenomath\csname old#1\endcsname}%
  {\csname oldend#1\endcsname\endlinenomath}}% 
\iflinenumbers
  \AtBeginDocument{%
    \patchMATHlinenumbers{equation}%
    \patchMATHlinenumbers{equation*}%
    \patchMATHlinenumbers{align}%
    \patchMATHlinenumbers{align*}%
    \patchMATHlinenumbers{flalign}%
    \patchMATHlinenumbers{flalign*}%
    \patchMATHlinenumbers{alignat}%
    \patchMATHlinenumbers{alignat*}%
    \patchMATHlinenumbers{gather}%
    \patchMATHlinenumbers{gather*}%
    \patchMATHlinenumbers{multline}%
    \patchMATHlinenumbers{multline*}%
  }
  \renewcommand\linenumberfont{\sffamily\scriptsize}
\fi

% Link packages.
\RequirePackage{xcolor}

\definecolor{linkBlue}{HTML}{0055C9}
\definecolor{linkRed}{HTML}{E41A1C}
\definecolor{linkGreen}{HTML}{4DAF4A}

\ifhidelinks%
  \RequirePackage[%
    colorlinks = false,
    hidelinks
  ]{hyperref}
\fi
\ifcolorlinks%
  \RequirePackage[%
    colorlinks = true,
    linkcolor  = linkBlue,
    citecolor  = linkRed,
    urlcolor   = linkGreen
  ]{hyperref}
\fi
\ifmonolinks%
  \RequirePackage[%
    colorlinks = true,
    allcolors  = linkBlue
  ]{hyperref}
\fi


\RequirePackage{url}
\RequirePackage{doi}
\PassOptionsToPackage{nameinlink, capitalize}{cleveref}

\AtBeginDocument{
  \RequirePackage{cleveref}

  % Change cleveref equations without eq.
  \crefformat{equation}{\textup{#2(#1)#3}}
  \crefrangeformat{equation}{\textup{#3(#1)#4--#5(#2)#6}}
  \crefmultiformat{equation}{\textup{#2(#1)#3}}{ and \textup{#2(#1)#3}}
    {, \textup{#2(#1)#3}}{, and \textup{#2(#1)#3}}
  \crefrangemultiformat{equation}{\textup{#3(#1)#4--#5(#2)#6}}%
    { and \textup{#3(#1)#4--#5(#2)#6}}{, \textup{#3(#1)#4--#5(#2)#6}}
    {, and \textup{#3(#1)#4--#5(#2)#6}}
  \Crefformat{equation}{\textup{#2Equation~(#1)#3}}
  \Crefrangeformat{equation}{\textup{#3Equations~(#1)#4--#5(#2)#6}}
  \Crefmultiformat{equation}{\textup{#2Equations~(#1)#3}}%
    { and \textup{#2(#1)#3}}
    {, \textup{#2(#1)#3}}{, and \textup{#2(#1)#3}}
  \Crefrangemultiformat{equation}{\textup{#3Equations~(#1)#4--#5(#2)#6}}%
    { and \textup{#3(#1)#4--#5(#2)#6}}{, \textup{#3(#1)#4--#5(#2)#6}}
    {, and \textup{#3(#1)#4--#5(#2)#6}}
}
