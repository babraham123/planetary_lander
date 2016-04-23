function J = compute_score(T, X, trajectory, consts)

x_error = X(1:3,:) - trajectory(1:3,:);
J = sum(x_error(:));

end