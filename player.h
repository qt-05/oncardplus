#ifndef PLAYER_H
#define PLAYER_H

#include <QObject>

class Player : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool player1_turn READ player1_turn WRITE setPlayer1_turn NOTIFY player1_turnChanged)
    Q_PROPERTY(bool player2_turn READ player2_turn WRITE setPlayer2_turn NOTIFY player2_turnChanged)
    Q_PROPERTY(bool player3_turn READ player3_turn WRITE setPlayer3_turn NOTIFY player3_turnChanged)
    Q_PROPERTY(bool player4_turn READ player4_turn WRITE setPlayer4_turn NOTIFY player4_turnChanged)
public:
    explicit Player(QObject *parent = 0):QObject(parent){}
    bool player1_turn() const;
    void setPlayer1_turn(bool player1_turn);
    bool player2_turn() const;
    void setPlayer2_turn(bool player2_turn);
    bool player3_turn() const;
    void setPlayer3_turn(bool player3_turn);
    bool player4_turn() const;
    void setPlayer4_turn(bool player4_turn);

public slots:
    void switchTurn1();
    void switchTurn2();
    void switchTurn3();
    void switchTurn4();

signals:
    void player1_turnChanged();
    void player2_turnChanged();
    void player3_turnChanged();
    void player4_turnChanged();

private:
    bool m_player1_turn;
    bool m_player2_turn;
    bool m_player3_turn;
    bool m_player4_turn;
};

#endif // GAMEDATA_H
