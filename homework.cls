% --- [ Preliminary Declarations ] -------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{homework}[2024/04/01 Panos' Homework Template]

% -- [ OPTIONS ] -----------------------------------------
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

% Extend the normal article class
\LoadClass[12pt]{article}

% Gimme cool packages
\RequirePackage[margin=1in]{geometry} 
\RequirePackage{amsmath,amsthm,amssymb,scrextend,amsfonts,mathtools}
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\RequirePackage{pgfplots}
\pgfplotsset{compat=1.18}
\RequirePackage{tikz}
\RequirePackage[mathscr]{euscript}
\let\euscr\mathscr \let\mathscr\relax% just so we can load this and rsfs
\RequirePackage[scr]{rsfso}
\RequirePackage{multicol}
\RequirePackage[colorlinks=true, pdfstartview=FitV, linkcolor=blue, citecolor=blue, urlcolor=blue]{hyperref}
\RequirePackage{physics}
\RequirePackage{tensor}
\RequirePackage[shortlabels]{enumitem}
\RequirePackage[makeroom]{cancel}
\RequirePackage{slashed}
\RequirePackage{graphicx}
\RequirePackage{aliascnt}
\RequirePackage[parfill]{parskip}
\usepackage{subcaption}


% -- [ DECLARATIONS ] ------------------------------------

\renewcommand{\maketitle}{%
    \setlength{\headheight}{15pt}%
    \lhead{\@title}%
    \chead{\@author}%
    \rhead{\today}%
}


% Problems
\newaliascnt{problem}{section} % so \autoref associates correct name with label
\providecommand{\problemname}{Problem}

\let\problemmark\@gobble
\let\toclevel@problem\toclevel@section % for PDF bookmarks

% disables numbering for exercises, for both actual headers and in TOC
\def\l@problem#1#2{\begingroup\let\numberline\@gobble\l@section{#1}{#2}\endgroup} % tex.stackexchange.com/a/62117
\def\@nonumsproblem{}
\def\@seccntformat#1{% www.texfaq.org/FAQ-seccntfmt
    \ifcsname @nonums#1\endcsname\else%
        \csname the#1\endcsname\quad% default behavior for other section types, from ltsect.dtx
    \fi%
}

\newcommand{\@problemsection}{% copied from article.cls and modified
    \@startsection%
        {problem}{1}{\z@}%
        {-3.5ex \@plus -1ex \@minus -.2ex}%
        {2.3ex \@plus.2ex}%
        {\normalfont\Large\bfseries}%
}
\newcommand*{\@problem}[1][\@nil]{% tex.stackexchange.com/a/217763
    \def\@arg{#1}%
    \begingroup\edef\x{\endgroup% expands problem counter for \nameref: tex.stackexchange.com/a/569405
        \noexpand\@problemsection{%
            \problemname{} % note: space
            \ifx\@arg\@nnil\the\numexpr\value{problem}+1\else#1\fi%
        }%
    }\x%
}
\newcommand{\problem}{\@ifstar{%
    \@problem%
}{%
    \ifnum\theproblem>0\newpage\fi%
    \@problem%
}}

% \if@localnums
%     \counterwithin{equation}{section} % resets equation counter for each section/exercise
% \fi

