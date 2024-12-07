import matplotlib.pyplot as plt
import numpy as np

# Scatter plot function
def scatter_plot_pc(reference, labels, study, pc_x, pc_y, ax=None):
    populations = np.unique(labels)
    for pop in populations:
        idx = labels == pop
        ax.scatter(reference[idx, pc_x], reference[idx, pc_y], label=pop, alpha=0.7)

    ax.scatter(study[:, pc_x], study[:, pc_y], color='black', marker='x', label='Study', alpha=0.7)
    ax.set_xlabel(f"PC{pc_x + 1}")
    ax.set_ylabel(f"PC{pc_y + 1}")
    ax.legend()
    ax.grid(True)

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
scatter_plot_pc(reference, population_labels, study, 0, 1, ax=axes[0, 0])
axes[0, 0].set_title("PC1 vs PC2")

# PC2 vs PC3
scatter_plot_pc(reference, population_labels, study, 1, 2, ax=axes[0, 1])
axes[0, 1].set_title("PC2 vs PC3")

# PC3 vs PC4
scatter_plot_pc(reference, population_labels, study, 2, 3, ax=axes[1, 0])
axes[1, 0].set_title("PC3 vs PC4")

# PC1 vs PC2 vs PC3 (3D)
ax3d = fig.add_subplot(2, 2, 4, projection='3d')
scatter_plot_pc3d(reference, population_labels, study, 0, 1, 2, ax=ax3d)
ax3d.set_title("PC1 vs PC2 vs PC3")

plt.tight_layout()
plt.show()

