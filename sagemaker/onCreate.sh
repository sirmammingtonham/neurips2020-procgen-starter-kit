# This file creates a symbolic link of folders in the neurips2020-progen-starter-kit to the SageMaker's one.

#### Warning: This file is ran by the notebooks. You should not have to manually run this file.

if [ -d "neurips2020-procgen-starter-kit" ]; then
    echo "Starter script found. Skipping steps"
    exit
fi

# Download the procgen-starter kit
git clone https://github.com/aicrowd/neurips2020-procgen-starter-kit
sed -i '/tensorflow==2.1.0/d' neurips2020-procgen-starter-kit/requirements.txt

# Remove the custom content
rm -r source/custom/algorithms source/custom/envs source/custom/models source/custom/preprocessors source/custom/experiments
rm source/custom/callbacks.py

# Create symbolic link
cd source/custom
ln -s ../../neurips2020-procgen-starter-kit/algorithms algorithms
ln -s ../../neurips2020-procgen-starter-kit/envs envs
ln -s ../../neurips2020-procgen-starter-kit/models models
ln -s ../../neurips2020-procgen-starter-kit/experiments experiments
ln -s ../../neurips2020-procgen-starter-kit/preprocessors preprocessors
ln -s ../../neurips2020-procgen-starter-kit/callbacks.py callbacks.py


# Bug fix in framestack.py
export REPLACE_STRING="\\
try:\\
    from envs.procgen_env_wrapper import ProcgenEnvWrapper\\
except ModuleNotFoundError:\\
    from custom.envs.procgen_env_wrapper import ProcgenEnvWrapper"

sed -i "s/from envs.procgen_env_wrapper import ProcgenEnvWrapper/${REPLACE_STRING}/g" envs/framestack.py

# Copy setup.py into the starter kit
cp setup.py ../../neurips2020-procgen-starter-kit/
