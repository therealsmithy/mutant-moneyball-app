library(rvest)

new_names <- gsub("\\s", "_", open$Member)

new_names <- paste0(new_names, "_(Earth-616)")

name_links <- paste0("https://marvel.fandom.com/wiki/", new_names)

name_link_df <- data.frame(name = new_names, 
                           link = name_links, 
                           error = NA)

cookie <- "wikia_beacon_id=ymaao2h9pC; _b2=bdgYkx45Rl.1728653455157; exp_bucket=11; exp_bucket_2=v2-14; Geo={%22region%22:%22IN%22%2C%22city%22:%22notre dame%22%2C%22country_name%22:%22united states%22%2C%22country%22:%22US%22%2C%22continent%22:%22NA%22}; usprivacy=1YNN; eb=36; wikia_session_id=jYZb-IJElx; cebs=1; fandom_global_id=8ccd2529-9c29-4dce-b720-5ace1646354b; __qca=P0-1360940126-1728653455950; _li_dcdm_c=.fandom.com; _lc2_fpi=17cd767946ca--01j9xwcwzgp1des1zzmek5qt4v; _lc2_fpi_meta=%7B%22w%22%3A1728653456368%7D; _pubcid=2cc4351d-f70f-43b7-9b3e-09df1822f074; _au_1d=AU1D-0100-001728653456-ER3XDCSH-K1EH; _cc_id=7367e916411a759a9134a27f3bb67263; _ga=GA1.1.810449113.1728653457; sharedId=c065c3e0-ade0-4308-b140-eb4f3499d279; sharedId_cst=zix7LPQsHA%3D%3D; fan_visited_wikis=509,1395682,2233,528941; active_cms_notification=446; sessionId=32e7d29e-dbb2-4672-8a1d-da8431e4c241; pvNumberGlobal=1; tracking_session_id=32e7d29e-dbb2-4672-8a1d-da8431e4c241; pv_number_global=1; AMP_MKTG_6765a55f49=JTdCJTdE; __bm_m=7e98643c037a475e983238214917e201%7Cfalse%7C0%7C0%7C-%7C1729807487363; panoramaId_expiry=1731686348449; panoramaId=411858469d1613a41545091cf23a185ca02c15671b12e426b80c9e7e85d2d4d1; panoramaIdType=panoDevice; nol_fpid=yyu8ay30ri7cybpxiyi9csjaz1ulc1728653456|1728653456754|1731081547224|1731081547489; _ce.clock_data=-1052%2C66.254.231.65%2C1%2C7675d59b5e84e0a878ee6f0a97f9056f%2CChrome%2CUS; cebsp_=15; __gads=ID=eedbe391d0dd83aa:T=1728653457:RT=1731081550:S=ALNI_MZbgA1mRmAP1ZVkqD2hcASwdT4p8w; __gpi=UID=00000f3abacbf881:T=1728653457:RT=1731081550:S=ALNI_MZBygvTbMSVxwpUuDT0LDB157bbSg; __eoi=ID=8aa3c684412d06cd:T=1728653457:RT=1731081550:S=AA-AfjbDtrV1DGzicpZwdswFB0iA; _pubcid_cst=3yxgLFoszg%3D%3D; spotim_visitId={%22visitId%22:%2220f45e07-9c0e-4a93-b88d-c264760112b3%22%2C%22creationDate%22:%22Fri%20Nov%2008%202024%2010:59:11%20GMT-0500%20(Eastern%20Standard%20Time)%22%2C%22duration%22:99}; cto_bundle=CP3oF18yUE04QTY3dmxTZ05JUWc2WjVrSGdvcmQwOXByZXdQRU9VMm54SjRvJTJGbFpFcDJOWmRBYXFUNU5VRzVkc2d1ZjEySEdwYUtYQzkzN0hGUjJWVEVZSTVrcEx4cGdlbjN4Mlp6aFFXY2g0RGdxUGVDSjE4RnJObWNoRzlMNFpGbTFiamZJUGpZQzhWWHV2dkZyM0lNeDVhWDdaVnk3WjZUUG1sTUpIaGRxNUR1ZGJJd1p2eXNrOUlGQm1RZWwzNU1KSk8lMkI5VzByTFZ5ZXNLR2RrOGlwSW0xUSUzRCUzRA; cto_bidid=IzyHNl9URWpzRiUyQnQ4YXlHZXFPUFQwVk9RMUglMkJsaSUyQjdmdk5sREZMbEg1SHBWNEVmMkczd1d6STN1UTRqZ3ZkOWtHM0tIMXBXcFlFOWU2MmYyYm1PU21LT2RVJTJGRXpOVmYwQlcxbFdlUGoxNXI4bndFJTNE; AMP_6765a55f49=JTdCJTIyZGV2aWNlSWQlMjIlM0ElMjIwMWIwOWZiNC0wZGM1LTQ3NTItOWRjNS04YWRiNTJlOTg2NDIlMjIlMkMlMjJzZXNzaW9uSWQlMjIlM0ExNzMxMDgxNTQ2Mzc2JTJDJTIyb3B0T3V0JTIyJTNBZmFsc2UlMkMlMjJsYXN0RXZlbnRUaW1lJTIyJTNBMTczMTA4MTY2NDE4NSUyQyUyMmxhc3RFdmVudElkJTIyJTNBOTYlN0Q=; _ga_FVWZ0RM4DH=GS1.1.1731081706.5.0.1731081706.60.0.0; _ce.s=v~02fc7f91024541da1ac68d614e45b062aaeaf2c1~lcw~1731081705855~vir~new~lva~1728653456219~vpv~0~v11.fhb~1731081547550~v11.lhb~1731081648687~v11.cs~362001~v11.s~62b2fc60-9dea-11ef-9bdb-1fbacbb1bc33~v11.sla~1731081706421~gtrk.la~m38xcnbq~v11.send~1731081705855~lcw~1731081706422"


lapply(1:nrow(name_link_df), function(x) {
  tryCatch({page <- read_html(name_link_df$link[x])
  
  picture_link <- page %>%
    html_elements("figure.pi-item a.image.image-thumbnail") %>% 
    html_attr("href")
  
  if (length(picture_link) == 0) {
    name_link_df$error[x] <- "No picture found"

  }
  
  picture_link <- gsub("/revision.*$", "", picture_link)
  
  download.file(
    picture_link, 
    destfile = paste0("images/", name_link_df$name[x], ".jpg"), 
    headers = c(
      "User-Agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36", 
      "Referer" = "https://marvel.fandom.com/", 
      "Cookie" = cookie
    ), 
    mode = "wb")
  
}, error = function(e) {
  message("Error at iteration ", x, ": ", e$message)
  name_link_df$error[x] <- 'Error - Image not found at link'
})
})

page_read <- read_html("https://marvel.fandom.com/wiki/Henry_McCoy_(Earth-616)")

quote <- page_read %>% 
  html_elements(".quote") %>%
  html_text()

first_line <- page_read %>% 
  html_elements("#mw-content-text .quote+p") %>%
  html_text() %>% 
  gsub("\\b(Dr)(\\.)", "\\1", .) %>% 
  gsub("\\.\\s.*$", "", .)
