package com.appdynamics.tools.gerritstats;

/**
 * Created by henry.wu on 6/23/16.
 */
public class CommitsStats {
    private int numOfCommits;
    private int linesOfInsertion;
    private int linesOfDeletion;

    public CommitsStats(int numOfCommits, int linesOfInsertion, int lineOfDeletion) {
        this.numOfCommits = numOfCommits;
        this.linesOfInsertion = linesOfInsertion;
        this.linesOfDeletion = lineOfDeletion;
    }

    public int getNumOfCommits() {
        return numOfCommits;
    }

    public void setNumOfCommits(int numOfCommits) {
        this.numOfCommits = numOfCommits;
    }

    public int getLinesOfInsertion() {
        return linesOfInsertion;
    }

    public void setLinesOfInsertion(int linesOfInsertion) {
        this.linesOfInsertion = linesOfInsertion;
    }

    public int getLinesOfDeletion() {
        return linesOfDeletion;
    }

    public void setLinesOfDeletion(int linesOfDeletion) {
        this.linesOfDeletion = linesOfDeletion;
    }
}
