push branch="main":
    for remote in origin github; do jj git push -b {{ branch }} --remote $remote; done
