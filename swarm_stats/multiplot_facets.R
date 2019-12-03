library(tidyverse)
library(scales)
library(viridis)

setwd("C:\\Users\\Milena K\\OneDrive\\Documents\\Master Biostudium\\Projekt_France")

## Plot the relation between cluster size and percentage of singletons for several datasets

## datasets
## All forest soils 18S V4 904 samples: all over the world
## 16S rRNA V3-V4: mediterrian soils
## 18S V9, 496 samples: all over the world
## Camargue 16S roots and stems: rice fields in Southern France


col_names <- c("Unique", "Abundance", "Center_Amplicon_Name",
               "Seed_Abundance", "Singletons", "Iterations", "Steps")

load_data <- function(input, project_name){
  read_tsv(input, n_max = 50000,col_names = col_names) %>% 
    mutate(Percentage_of_Singletons = 100 * Singletons / Abundance) %>% 
    mutate(Ratio_Seed_Abundance_Total_Abundance = Seed_Abundance / Abundance)  %>%
    mutate(project = project_name) %>% 
    arrange(Abundance)
}


bind_rows(load_data("all_forest_soils_18S_V4_904_samples_1f.stats", "18S V4"),
          load_data("16S_V3_V4_1332_samples_1f.stats", "16S V3-V4"),
          load_data("18S_V9_496_samples_1f.stats", "18S V9"), 
          load_data("Camargue_16S_roots_and_stems_20190920_1593_samples_1f.stats", "16S Camargue")) %>%
ggplot(aes(x = Abundance,
           y = Percentage_of_Singletons,
           color = Ratio_Seed_Abundance_Total_Abundance)) +
  scale_colour_viridis(name = "Seed Abundance\nto total Abundance") +
  geom_point(size = 0.02) +
  ylim(0,100) +
  scale_x_log10(limits = c(10,10e6),
                name = "Total Abundance of Amplicons\n(Cluster Size)",
                breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x))) +
  theme_bw(base_size = 16) +
  theme(legend.position = "bottom", 
        legend.text = element_text(size = 9)) +
  labs(y = "% Singletons") +
  facet_grid(. ~ project)

ggsave("multiplot_facets.pdf", width = 16, height = 9)
