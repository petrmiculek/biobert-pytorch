# import numpy as np
# import pandas as pd
# import matplotlib.pyplot as plt
# import seaborn as sns

import os
import sys


def get_f1(path):
    with open(path, 'r') as f:
        lines = f.readlines()
        if len(lines) < 4:
            raise ValueError()

        f1_line = lines[3]
        # line looks like: 'test_f1 = 0.035916125283895844'
        return float(f1_line[f1_line.find('=') + 2:])


if __name__ == '__main__':
    root = sys.argv[1]
    # root = '../output'

    dataset_dirs = os.listdir(root)
    results_filename = 'test_results.txt'

    f1s = {}
    # dataset
    for dataset in dataset_dirs:
        dataset_dir_path = os.path.join(root, dataset)
        if not os.path.isdir(dataset_dir_path):
            continue

        # model (1/2) or (1/1)
        model_dirs = os.listdir(dataset_dir_path)

        models_and_paths = []
        for model_dir in model_dirs:
            dataset_model_path = os.path.join(dataset_dir_path, model_dir)
            if not os.path.isdir(dataset_model_path):
                continue

            if model_dir == 'dmis-lab':
                # double-step
                dmis_models_path = os.path.join(dataset_dir_path, model_dir)
                for dmis_model in os.listdir(dmis_models_path):
                    dataset_model_path = os.path.join(dataset_dir_path, model_dir, dmis_model)
                    models_and_paths.append((dmis_model, dataset_model_path))

            else:
                models_and_paths.append((model_dir, dataset_model_path))

        for model, model_path in models_and_paths:
            result_level_files = os.listdir(model_path)

            if results_filename not in result_level_files:
                # print(f'No results in: {result_level_files}')
                continue

            results_path = os.path.join(dataset_dir_path, results_filename)
            f1 = get_f1(results_path)
            print(dataset, model, f1)
            # f1s[dataset] = f1


