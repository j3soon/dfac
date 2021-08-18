# Distributional Value Factorization (DFAC) Framework

This is the official repository that contain the source code for the DFAC paper:

- [[ICML 2021] DFAC Framework: Factorizing the Value Function via Quantile Mixture for Multi-Agent Distributional Q-Learning](http://proceedings.mlr.press/v139/sun21c.html)
- The preprint version and further revisions can be found on [arXiv](https://arxiv.org/abs/2102.07936).

If you have any question regarding the paper or code, ask by [submitting an issue](https://github.com/j3soon/dfac/issues).

## Gameplay Video Preview

Learned policy of DDN on Super Hard & Ultra Hard maps:

https://youtu.be/MLdqyyPcv9U

## Installation

Install docker, nvidia-docker, and nvidia-container-runtime. You can refer to [this document](https://abstractionrevealed.com/getting-started-with-python/#docker-containers) for installation instructions.

Execute the following commands in your Linux terminal to build the docker image:

```sh
# Clone the repository
git clone https://github.com/j3soon/dfac.git
cd dfac
# Download StarCraft 2.4.10
wget http://blzdistsc2-a.akamaihd.net/Linux/SC2.4.10.zip
# Extract the files to StarCraftII directory
unzip -P iagreetotheeula SC2.4.10.zip
mv SC2.4.10.zip ..
# Build docker image
docker build . --build-arg DOCKER_BASE=nvcr.io/nvidia/tensorflow:19.12-tf1-py3 -t j3soon/dfac:1.0
```

Launch a docker container:

```sh
docker run --gpus all \
    --shm-size=1g --ulimit memlock=-1 --ulimit stack=67108864 \
    --rm \
    -it \
    -v "$(pwd)"/pymarl:/root/pymarl \
    -v "$(pwd)"/results:/results \
    -e DISPLAY=$DISPLAY \
    --device /dev/snd \
    j3soon/dfac:1.0 /bin/bash
```

Run the following command in the docker container for quick testing:

```sh
cd /root/pymarl
python3 src/main.py --config=ddn --env-config=sc2 with env_args.map_name=3m t_max=50000
```

After finish training, exit the container by `exit`, the container will be automatically deleted thanks to the `--rm` flag.

The results are stored in `./results`.

> We chose to release the code based on docker for better reproducibility and the ease of use. For installing directly or running the code in virtualenv or conda, you may want to refer to the [Dockerfile](Dockerfile). If you still have trouble setting up the environment, [open an issue](https://github.com/j3soon/dfac/issues) and describe your encountered issue.

## Reproducing

The following is the list of commands used for the experiments in the paper:

```sh
# 3s5z_vs_3s6z
python3 src/main.py --config=iql --env-config=sc2 with env_args.map_name=3s5z_vs_3s6z rnn_hidden_dim=512
python3 src/main.py --config=vdn --env-config=sc2 with env_args.map_name=3s5z_vs_3s6z rnn_hidden_dim=128
python3 src/main.py --config=qmix --env-config=sc2 with env_args.map_name=3s5z_vs_3s6z rnn_hidden_dim=128
python3 src/main.py --config=diql --env-config=sc2 with env_args.map_name=3s5z_vs_3s6z rnn_hidden_dim=256
python3 src/main.py --config=ddn --env-config=sc2 with env_args.map_name=3s5z_vs_3s6z rnn_hidden_dim=512
python3 src/main.py --config=dmix --env-config=sc2 with env_args.map_name=3s5z_vs_3s6z rnn_hidden_dim=256
# 6h_vs_8z
python3 src/main.py --config=iql --env-config=sc2 with env_args.map_name=6h_vs_8z rnn_hidden_dim=128
python3 src/main.py --config=vdn --env-config=sc2 with env_args.map_name=6h_vs_8z rnn_hidden_dim=128
python3 src/main.py --config=qmix --env-config=sc2 with env_args.map_name=6h_vs_8z rnn_hidden_dim=256
python3 src/main.py --config=diql --env-config=sc2 with env_args.map_name=6h_vs_8z rnn_hidden_dim=512
python3 src/main.py --config=ddn --env-config=sc2 with env_args.map_name=6h_vs_8z rnn_hidden_dim=512
python3 src/main.py --config=dmix --env-config=sc2 with env_args.map_name=6h_vs_8z rnn_hidden_dim=256
# MMM2
python3 src/main.py --config=iql --env-config=sc2 with env_args.map_name=MMM2 rnn_hidden_dim=256
python3 src/main.py --config=vdn --env-config=sc2 with env_args.map_name=MMM2 rnn_hidden_dim=64
python3 src/main.py --config=qmix --env-config=sc2 with env_args.map_name=MMM2 rnn_hidden_dim=64
python3 src/main.py --config=diql --env-config=sc2 with env_args.map_name=MMM2 rnn_hidden_dim=512
python3 src/main.py --config=ddn --env-config=sc2 with env_args.map_name=MMM2 rnn_hidden_dim=512
python3 src/main.py --config=dmix --env-config=sc2 with env_args.map_name=MMM2 rnn_hidden_dim=256
# 27m_vs_30m
python3 src/main.py --config=iql --env-config=sc2 with env_args.map_name=27m_vs_30m rnn_hidden_dim=256
python3 src/main.py --config=vdn --env-config=sc2 with env_args.map_name=27m_vs_30m rnn_hidden_dim=64
python3 src/main.py --config=qmix --env-config=sc2 with env_args.map_name=27m_vs_30m rnn_hidden_dim=64
python3 src/main.py --config=diql --env-config=sc2 with env_args.map_name=27m_vs_30m rnn_hidden_dim=512
python3 src/main.py --config=ddn --env-config=sc2 with env_args.map_name=27m_vs_30m rnn_hidden_dim=128
python3 src/main.py --config=dmix --env-config=sc2 with env_args.map_name=27m_vs_30m rnn_hidden_dim=128
# corridor
python3 src/main.py --config=iql --env-config=sc2 with env_args.map_name=corridor rnn_hidden_dim=256
python3 src/main.py --config=vdn --env-config=sc2 with env_args.map_name=corridor rnn_hidden_dim=128
python3 src/main.py --config=qmix --env-config=sc2 with env_args.map_name=corridor rnn_hidden_dim=256
python3 src/main.py --config=diql --env-config=sc2 with env_args.map_name=corridor rnn_hidden_dim=512
python3 src/main.py --config=ddn --env-config=sc2 with env_args.map_name=corridor rnn_hidden_dim=128
python3 src/main.py --config=dmix --env-config=sc2 with env_args.map_name=corridor rnn_hidden_dim=64
```

If you want to modify the algorithm, you can modify the files in `./pymarl` directly, without rebuilding the docker image or restarting the docker container.

## Compare Baseline code with DFAC code

The code of DFAC is organized with minimum changes based on [oxwhirl/pymarl](https://github.com/oxwhirl/pymarl) for readibility. You may want to compare the baselines with their DFAC variants with the following commands:

```sh
# Configs
diff pymarl/src/config/algs/iql.yaml pymarl/src/config/algs/diql.yaml
diff pymarl/src/config/algs/vdn.yaml pymarl/src/config/algs/ddn.yaml
diff pymarl/src/config/algs/qmix.yaml pymarl/src/config/algs/dmix.yaml
# Agent
diff pymarl/src/learners/q_learner.py pymarl/src/learners/iqn_learner.py
diff pymarl/src/modules/agents/rnn_agent.py pymarl/src/modules/agents/iqn_rnn_agent.py
# Mixer
diff pymarl/src/modules/mixers/vdn.py pymarl/src/modules/mixers/ddn.py
diff pymarl/src/modules/mixers/qmix.py pymarl/src/modules/mixers/dmix.py
```

For comparing all modifications based on all used packages, refer to [this comparison link of all modifications](https://github.com/j3soon/dfac/compare/61d2a06..HEAD).

## Developing new Algorithms

### Updaing Packages

Since this repository is frozen in old commits for reproducibility, you may want to use the newest packages:

- [oxwhirl/sacred](https://github.com/oxwhirl/sacred)
- [oxwhirl/smac](https://github.com/oxwhirl/smac)
- [oxwhirl/pymarl](https://github.com/oxwhirl/pymarl)

For common baselines, you may want to refer to the following package which collected a bunch of baselines:

- [hijkzzz/pymarl2](https://github.com/hijkzzz/pymarl2)

### Inspect the Training Progress

You can inspect the training progress in real-time by the following command:

```sh
tensorboard --logdir=./results
```

## Citing DFAC

If you used the provided code or want to cite our work, please cite the [DFAC paper](http://proceedings.mlr.press/v139/sun21c.html).

BibTex format:

```
@InProceedings{sun21dfac,
  title = 	 {{DFAC} Framework: Factorizing the Value Function via Quantile Mixture for Multi-Agent Distributional Q-Learning},
  author =       {Sun, Wei-Fang and Lee, Cheng-Kuang and Lee, Chun-Yi},
  booktitle = 	 {Proceedings of the 38th International Conference on Machine Learning},
  pages = 	 {9945--9954},
  year = 	 {2021},
  volume = 	 {139},
  series = 	 {Proceedings of Machine Learning Research},
  month = 	 {18--24 Jul},
  publisher =    {PMLR},
  pdf = 	 {http://proceedings.mlr.press/v139/sun21c/sun21c.pdf},
  url = 	 {http://proceedings.mlr.press/v139/sun21c.html},
}
```

You will also want to [cite the SMAC paper](https://github.com/oxwhirl/smac#citing--smac) for providing the benchmark used in the paper.

## License

To maintain reproducibility, we freezed the following packages with the commit used in the paper. The licenses of these packages are listed below:

- [oxwhirl/sacred](https://github.com/oxwhirl/sacred) (at commit 13f04ad) is released under the [MIT License](https://github.com/oxwhirl/sacred/blob/master/LICENSE.txt)
- [oxwhirl/smac](https://github.com/oxwhirl/smac) (at commit 8d2c42b) is released under the [MIT License](https://github.com/oxwhirl/smac/blob/master/LICENSE)
- [oxwhirl/pymarl](https://github.com/oxwhirl/pymarl) (at commit dd92936) is released under the [Apache-2.0 License](https://github.com/oxwhirl/pymarl/blob/master/LICENSE)

Further changes based on the packages above are release under the [Apache-2.0 License](LICENSE).
