function [] = plotTrajectory(positions, labels)
[n_dim, n_samples] = size(positions);
figure();
plot(positions');

if exist("labels", "var")
    legend(labels)
end
end

