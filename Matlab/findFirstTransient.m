function indx = findFirstTransient(x, dbThreshold)

indx = -1
magThreshold = db2mag(dbThreshold);

for n = 1:length(x)
    if abs(x(n)) > magThreshold
        indx = n;
        break;
    end
end
end