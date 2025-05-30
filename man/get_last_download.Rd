% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/download_eden.R
\name{get_last_download}
\alias{get_last_download}
\title{Get list of EDEN depths data already downloaded}
\usage{
get_last_download(
  eden_path = file.path("Water"),
  metadata,
  force_update = FALSE
)
}
\arguments{
\item{eden_path}{path where the EDEN data should be stored}

\item{metadata}{EDEN file metadata}

\item{force_update}{if TRUE update all data files even if checks indicate
that remote files are unchanged since the current local copies were
created}
}
\value{
table of files already downloaded
}
\description{
Get list of EDEN depths data already downloaded
}
