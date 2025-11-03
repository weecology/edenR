#' @name get_eden_data
#'
#' @title Downloads new EDEN depth data, calculates covariates, appends to covariate file
#'
#' @param eden_path path where the EDEN data should be stored
#'
#' @export
#'

get_eden_data <- function(eden_path = file.path("~/water")) {

metadata <- get_metadata()
last_download <- get_last_download(eden_path)

if(identical(metadata,last_download)) {
  return(NULL)
} else {

download_eden_depths(eden_path, force_update = FALSE) 
  
years = available_years(eden_path, new = TRUE)

if (!("eden_covariates" %in% list.files(eden_path))) {
  covariate_data <- read.table(file.path(eden_path,"eden_covariates.csv"), header = TRUE, sep = ",")
new_covariates <- get_eden_covariates(eden_path = eden_path, 
                                      years=years) %>%
                  dplyr::bind_rows(get_eden_covariates(eden_path = eden_path,
                                                       level="all", 
                                                       years=years)) %>%
                  dplyr::bind_rows(get_eden_covariates(eden_path = eden_path,
                                                       level="wcas", 
                                                       years=years)) %>%
                  dplyr::select(year, region=Name, variable, value) %>%
                  as.data.frame() %>%
                  dplyr::select(-geometry) %>%
                  tidyr::pivot_wider(names_from="variable", values_from="value") %>%
                  dplyr::mutate(year = as.integer(year)) %>%
                  dplyr::arrange("year", "region")
covariate_data <- dplyr::filter(covariate_data, !year %in% new_covariates$year) %>%
                  rbind(new_covariates) %>%
                  dplyr::arrange("year", "region")

depth_data <- read.table(file.path(eden_path,"eden_depth.csv"), header = TRUE, sep = ",") %>%
              dplyr::mutate(date=as.Date(date))
new_depths <- get_eden_depths(eden_path = eden_path, 
                              years=years) %>%
              dplyr::bind_rows(get_eden_depths(eden_path = eden_path,
                                               level="all", 
                                               years=years)) %>%
              dplyr::bind_rows(get_eden_depths(eden_path = eden_path,
                                               level="wcas", 
                                               years=years)) %>%
              dplyr::mutate(date=as.Date(date))

depth_data <- dplyr::filter(depth_data, !date %in% new_depths$date) %>%
              rbind(new_depths) %>%
              dplyr::arrange("date", "region")

update_last_download(eden_path = eden_path, metadata = metadata)
}

return(list(covariate_data=covariate_data, depth_data=depth_data))
}

#' @name update_water
#'
#' @title Writes new water data
#'
#' @param eden_path path where the EDEN data should be stored
#'
#' @export
#'

update_water <- function(eden_path) {

  data <- get_eden_data(eden_path)

  if(is.null(data)) {
    return(cat("...No new data..."))
    } else {

  write.table(data$covariate_data, file = file.path(eden_path,"eden_covariates.csv"), row.names = FALSE, col.names = TRUE,
            na="", sep = ",", quote = FALSE)

  write.table(data$depth_data, file = file.path(eden_path,"eden_depth.csv"),
              row.names = FALSE, col.names = TRUE, na = "", sep = ",", quote = FALSE)
    }
}
