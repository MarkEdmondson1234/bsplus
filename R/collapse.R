#' Collapsible element
#'
#' This is useful for content that you may wish to be hidden when the page is
#' initialized, but that can be revealed (and subsequently hidden)
#' by clicking a button or a link.
#'
#' There are two parts to this system:
#'
#' \enumerate{
#'   \item{A collapsible \code{<div/>}, created using \code{bs_collapse()}}
#'   \item{At least one button (\code{<button/>}) or link (\code{<a/>})
#'   to which the \code{id} of the collapsible \code{<div/>} is attached,
#'   using \code{bs_attach_collapse()}}
#' }
#'
#' The verb \emph{attach} is used to signify that we are attaching the
#' \code{id} of our collapsible
#' \code{<div/>} to the tag in question (a button or a link).
#' Note that you can attach the \code{id} of a collapsible
#' \code{<div/>} to more than one button or link.
#'
#' It is your responsibility to ensure that \code{id} is unique
#' among HTML elements in your page. If you have non-unique \code{id}'s,
#' strange things may happen to your page.
#'
#' @param id           character, unique id for the collapsible \code{<div/>}
#' @param content      character (HTML) or
#'   \code{htmltools::\link[htmltools]{tagList}},
#'   content for the collapsible \code{<div/>}
#' @param show         logical, indicates if collapsible \code{<div/>}
#'   is shown when page is initialized
#' @param tag          \code{htmltools::\link[htmltools]{tag}},
#'   button or link to which to attach a collapsible \code{<div/>}
#' @param id_collapse  character, \code{id} of
#'   the collapsible \code{<div/>} to attach
#'
#' @return
#' \describe{
#'   \item{\code{bs_collapse()}}{\code{htmltools::\link[htmltools]{tag}},
#'   \code{<div/>}}
#'   \item{\code{bs_attach_collapse()}}{\code{htmltools::\link[htmltools]{tag}},
#'     modified copy of \code{tag} (button or link)}
#' }
#'
#' @examples
#' library("htmltools")
#'
#' bs_collapse(id = "id_yeah", tags$p("Yeah Yeah Yeah"))
#'
#' tags$button(type = "button", class = "btn btn-default", "She Loves You") %>%
#'   bs_attach_collapse("id_yeah")
#'
#' @seealso \url{https://getbootstrap.com/javascript/#collapse}
#'
#' @export
#'
bs_collapse <- function(id, content = NULL, show = FALSE){

  tag <- htmltools::tags$div(class = "collapse", id = id, content)

  if (show){
    tag <- htmltools::tagAppendAttributes(tag, class = "in")
  }

  tag
}

#' @rdname bs_collapse
#' @export
#'
bs_attach_collapse <- function(tag, id_collapse){

  tag <- .tag_validate(tag)

  tag <- bs_set_data(tag, toggle = "collapse")

  if (identical(tag$name, "a")){
    # link
    tag <- htmltools::tagAppendAttributes(
      tag,
      role = "button",
      href = .id(id_collapse)
    )
  } else {
    # not a link
    tag <- bs_set_data(tag, target = .id(id_collapse))
  }

  tag
}

