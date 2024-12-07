import matplotlib.pyplot as plt
import numpy as np
import argparse
import pandas as pd

def connect_ancestry_ref(ancestries, ref):
    ref_df = pd.read_csv(ref, sep="\t") 

# Scatter plot function
def scatter_plot_pc(reference, labels, study, figure_name, pc_x, pc_y, ax=None):
    populations = np.unique(labels)
    for pop in populations:
        idx = labels == pop
        ax.scatter(reference[idx, pc_x], reference[idx, pc_y], label=pop, alpha=0.7)

    ax.scatter(study[:, pc_x], study[:, pc_y], color='black', marker='x', label='Study', alpha=0.7)
    ax.set_xlabel(f"PC{pc_x + 1}")
    ax.set_ylabel(f"PC{pc_y + 1}")
    ax.set_title(figure_name)
    ax.legend()
    ax.grid(True)
    ax.savefig(figure_name+'.png') 
  
def scatter_plot_pc3d( ax=None):
    populations = np.unique(labels)
    for pop in populations:
        idx = labels == pop
        ax.scatter(reference[idx, pc_x], reference[idx, pc_y], label=pop, alpha=0.7) 

    ax.add_subplot(projection='3d')
    ax.scatter(xs, ys, zs, marker=m)
    ax.set_xlabel('X Label')
    ax.set_ylabel('Y Label')
    ax.set_zlabel('Z Label')

# Main plotting
reference, population_labels, study = generate_data()
population_labels = np.array(population_labels) 

fig, axes = plt.subplots(2, 2, figsize=(12, 10))

# PC1 vs PC2
scatter_plot_pc(reference, population_labels, study, "PC1 vs PC2", 0, 1, ax=axes[0, 0])

# PC2 vs PC3
scatter_plot_pc(reference, population_labels, study, "PC2 vs PC3", 1, 2, ax=axes[0, 1])

# PC3 vs PC4
scatter_plot_pc(reference, population_labels, study, "PC3 vs PC4", 2, 3, ax=axes[1, 0])

# PC1 vs PC2 vs PC3 (3D)
ax3d = fig.add_subplot(2, 2, 4, projection='3d')
scatter_plot_pc3d(reference, population_labels, study, "PC1 vs PC2 vs PC3", 0, 1, 2, ax=ax3d)

plt.tight_layout()
plt.show()

def main():
    parser = argparse.ArgumentParser(description="Process an array of files.")
    parser.add_argument("--ancestry_pcs", required=True, help="Comma-separated list of ancestry pcs path")
    parser.add_argument("--merged_refs", required=True, help="merged 1000 genome reference file")
    args = parser.parse_args()

    ancestry_list = args.ancestry_pcs.split(",")
    ref = args.merged_refs()

if __name__ == "__main__":
    main()
