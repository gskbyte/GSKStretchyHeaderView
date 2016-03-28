#import <GSKStretchyHeaderView/GSKStretchyHeaderView.h>

@protocol  GSKTwitterStretchyHeaderViewDelegate;

@interface GSKTwitterStretchyHeaderView : GSKStretchyHeaderView
@property (weak, nonatomic) id<GSKTwitterStretchyHeaderViewDelegate> delegate;
@end

@protocol GSKTwitterStretchyHeaderViewDelegate <NSObject>

- (void)headerView:(GSKTwitterStretchyHeaderView *)headerView
  didTapBackButton:(id)sender;

@end
