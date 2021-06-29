FROM ubuntu:20.04

ENV repo_url=https://github.com/mike-vasylchenko1/actions-demo
ENV runner_token=token

RUN apt-get update
RUN apt-get install -y curl tar uuid-runtime maven

RUN mkdir /actions-runner
WORKDIR /actions-runner

RUN curl -o actions-runner-linux-x64-2.278.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.278.0/actions-runner-linux-x64-2.278.0.tar.gz
RUN tar xzf ./actions-runner-linux-x64-2.278.0.tar.gz
RUN printf '2\n47\n' | ./bin/installdependencies.sh

RUN adduser --system --group runner
RUN chown -R runner:runner /actions-runner
USER runner



CMD random=$(echo $(uuidgen) | awk -F - '{ print $1 }') && printf "fortna-demo-${random}\nfortna-runner\n_work\n" | ./config.sh --url ${repo_url} --token ${runner_token} && /actions-runner/run.sh
